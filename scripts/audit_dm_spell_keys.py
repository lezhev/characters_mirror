#!/usr/bin/env python3
"""Read-only audit: Foundry NPC spells -> SpellData.referenceKey.

Rule: srd5e.hash (decoded, without its source suffix) when available,
otherwise the English item name; lowercase snake_case; exact key + level.
No translations, aliases, fuzzy matching, writes to the database, or AI.
"""
from __future__ import annotations

import argparse
import csv
import json
import os
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from urllib.parse import unquote


def snake_key(text: str) -> str:
    text = unquote(text).casefold().replace("\u2019", "'")
    text = text.replace("'", "")
    return re.sub(r"[^a-z0-9]+", "_", text).strip("_")


def candidate_for(item: dict) -> tuple[str, str]:
    flags = item.get("flags")
    srd = (flags or {}).get("srd5e") or {}
    if isinstance(srd, dict) and isinstance(srd.get("hash"), str) and srd["hash"]:
        decoded = unquote(srd["hash"])
        source = str(srd.get("source") or "").strip().casefold()
        if source and decoded.casefold().endswith("_" + source):
            decoded = decoded[: -(len(source) + 1)]
        return snake_key(decoded), "srd5e.hash"
    name = str(item.get("name") or "").strip()
    # Cyrillic-only names cannot be converted to English reference keys.
    return snake_key(name), "item.name"


def load_actors(path: Path):
    """Yield only real Foundry NPC actors, not 5etools arrays or PC exports."""
    if path.suffix.lower() in (".db", ".jsonl"):
        with path.open(encoding="utf-8-sig") as f:
            for line_number, line in enumerate(f, 1):
                if not line.strip():
                    continue
                try:
                    value = json.loads(line)
                except json.JSONDecodeError as exc:
                    raise ValueError(f"{path}:{line_number}: {exc}") from exc
                if isinstance(value, dict) and value.get("type") == "npc" and isinstance(value.get("items"), list):
                    yield value
    elif path.suffix.lower() == ".json":
        try:
            value = json.loads(path.read_text(encoding="utf-8-sig"))
        except (ValueError, UnicodeError) as exc:
            raise ValueError(f"{path}: {exc}") from exc
        if isinstance(value, dict) and value.get("type") == "npc" and isinstance(value.get("items"), list):
            yield value


def source_files(paths: list[Path]) -> list[Path]:
    files: dict[str, Path] = {}
    for path in paths:
        if path.is_dir():
            for child in sorted(path.iterdir()):
                if child.is_file() and child.suffix.lower() in (".json", ".jsonl", ".db"):
                    files[str(child.resolve()).casefold()] = child
        elif path.is_file():
            files[str(path.resolve()).casefold()] = path
        else:
            raise FileNotFoundError(path)
    return list(files.values())


def catalog_keys(args) -> dict[str, tuple[str, int | None]]:
    try:
        import psycopg2
    except ImportError as exc:
        raise SystemExit("psycopg2 required (pip install psycopg2-binary)") from exc
    connection_args = dict(
        host=args.db_host, port=args.db_port, dbname=args.db_name,
        user=args.db_user, connect_timeout=5,
    )
    if args.db_password_env:
        password = os.getenv(args.db_password_env)
        if password is None:
            raise SystemExit(f"Environment variable {args.db_password_env} is not set")
        connection_args["password"] = password
    conn = psycopg2.connect(**connection_args)
    try:
        conn.set_session(readonly=True, autocommit=True)
        with conn.cursor() as cur:
            cur.execute('SELECT "referenceKey", name, level FROM spell_data')
            values = cur.fetchall()
    finally:
        conn.close()
    result: dict[str, tuple[str, int | None]] = {}
    for key, name, level in values:
        if key:
            result[str(key)] = (str(name or ""), level)
    return result


def save_csv(path: Path, columns: list[str], rows: list[dict]) -> None:
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=columns, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--source", action="append", required=True, type=Path,
                    help="Foundry NPC JSON, JSONL/.db or directory (repeatable)")
    ap.add_argument("--out-dir", required=True, type=Path)
    ap.add_argument("--db-host", default="127.0.0.1")
    ap.add_argument("--db-port", type=int, default=5432)
    ap.add_argument("--db-name", default="characters_mirror")
    ap.add_argument("--db-user", default="postgres")
    ap.add_argument("--db-password-env", default=None)
    args = ap.parse_args()

    catalog = catalog_keys(args)
    all_files = source_files(args.source)
    grouped: dict[tuple[str, int | None], dict] = {}
    uses: list[dict] = []
    actor_count = spell_count = files_with_npcs = 0
    for path in all_files:
        actors_in_file = 0
        for actor in load_actors(path):
            actor_count += 1
            actors_in_file += 1
            actor_name = str(actor.get("name") or "Без названия")
            actor_id = str(actor.get("_id") or actor_name)
            for item in actor["items"]:
                if not isinstance(item, dict) or item.get("type") != "spell":
                    continue
                spell_count += 1
                level_raw = (item.get("system") or {}).get("level")
                level = level_raw if type(level_raw) is int else None
                key, method = candidate_for(item)
                display = str(item.get("name") or "Без названия")
                identity = key if key else "unnamed:" + display.casefold()
                group_id = (identity, level)
                group = grouped.setdefault(group_id, {
                    "candidate": key, "level": level, "names": set(),
                    "sources": set(), "methods": set(), "creatures": set(),
                    "hashes": set(), "count": 0,
                })
                group["names"].add(display)
                group["methods"].add(method)
                group["sources"].add(path.name)
                group["creatures"].add((path.name, actor_id))
                h = ((item.get("flags") or {}).get("srd5e") or {}).get("hash")
                if h:
                    group["hashes"].add(str(h))
                group["count"] += 1
                uses.append({
                    "source_file": path.name, "creature": actor_name,
                    "actor_id": actor_id, "foundry_name": display,
                    "level": level, "candidate": key, "method": method,
                })
        if actors_in_file:
            files_with_npcs += 1

    rows: list[dict] = []
    status_count = Counter()
    for (_, level), group in sorted(grouped.items(), key=lambda kv: (kv[1]["candidate"], str(kv[1]["level"]))):
        candidate = group["candidate"]
        matched = catalog.get(candidate)
        if not candidate:
            status = "no_english_key"
        elif matched is None:
            status = "not_found"
        elif level is not None and matched[1] is not None and matched[1] != level:
            status = "level_mismatch"
        else:
            status = "matched"
        status_count[status] += 1
        rows.append({
            "status": status,
            "candidate": candidate,
            "referenceKey": candidate if status == "matched" else "",
            "foundry_names": " | ".join(sorted(group["names"])),
            "level": level,
            "catalog_name": matched[0] if matched else "",
            "catalog_level": matched[1] if matched else "",
            "instances": group["count"],
            "creature_count": len(group["creatures"]),
            "source_method": " | ".join(sorted(group["methods"])),
            "hashes": " | ".join(sorted(group["hashes"])),
            "source_files": " | ".join(sorted(group["sources"])),
        })

    args.out_dir.mkdir(parents=True, exist_ok=True)
    save_csv(args.out_dir / "unique_foundry_spells.csv", [
        "status", "candidate", "referenceKey", "foundry_names", "level",
        "catalog_name", "catalog_level", "instances", "creature_count",
        "source_method", "hashes", "source_files",
    ], rows)
    save_csv(args.out_dir / "spell_occurrences.csv", [
        "source_file", "creature", "actor_id", "foundry_name",
        "level", "candidate", "method",
    ], uses)
    summary = {
        "files_scanned": len(all_files),
        "files_with_npc_actors": files_with_npcs,
        "npc_actors": actor_count,
        "spell_occurrences": spell_count,
        "unique_spell_entries": len(grouped),
        "catalog_keys": len(catalog),
        "match_rule": "percent-decode srd5e.hash and remove matching source suffix; else item.name; lowercase snake_case; exact referenceKey and level",
        "statuses": dict(status_count),
    }
    (args.out_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(json.dumps(summary, ensure_ascii=True, indent=2))
    print("Unmatched:")
    for row in rows:
        if row["status"] != "matched":
            print(json.dumps({k: row[k] for k in ("status", "foundry_names", "candidate", "level", "instances")}, ensure_ascii=True))
    print("Outputs:", args.out_dir)


if __name__ == "__main__":
    main()
