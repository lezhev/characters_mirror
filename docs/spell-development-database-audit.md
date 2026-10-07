# Spell development database audit — 2026-10-07

Продолжение spell presentation / cast refactor. Входной незакоммиченный worktree принят за baseline. Пользователь разрешил изменение локальной development БД и отдельно подтвердил `create-migration --force` для описанного ниже hardening.

## 1. Найденная development БД

`localhost:5432 / characters_mirror`, пользователь `postgres`, PostgreSQL **17.5**, Windows service `postgresql-x64-17`. Подключение фактически завершалось на `127.0.0.1:5432`. Параметры сверены с `config/development.yaml`; пароль взят из локального `config/passwords.yaml` и передавался процессу через environment, без вывода и записи в отчёт.

Docker PostgreSQL на 8090 и существующая test-БД на 9090 не использовались как источник истины для SpellData.

## 2. Состояние до изменений

Applied project migration: `20261006223316590-spell-cast-sources`. `characters.currentPactSlots` уже существовала, nullable JSON. Это проверено SQL до изменений в этой итерации.

| Проверка | До | После |
|---|---:|---:|
| SpellData rows | 514 | 514 |
| NULL referenceKey | 0 | 0 |
| Empty/whitespace referenceKey | 0 | 0 |
| Duplicate key groups | 0 | 0 |
| Distinct referenceKey | 514 | 514 |
| Suspicious key format/casing/whitespace | 0 | 0 |
| Duplicate name + level groups | 0 | 0 |
| Missing description | 0 | 0 |
| Missing shortDescription | 514 | 514 |
| Class grants | 50 | 50 |
| Race grants | 0 | 0 |
| Character spell selections | 48 | 48 |
| Spell slot progression rows | 40 | 40 |

Уровни 0–9: **46, 77, 87, 74, 52, 61, 47, 28, 22, 20** строк соответственно.

Источники: PHB 2014 — 361; XGE — 95; TCE — 17; SCAG, TCE — 4; AAG — 2; AI — 7; BMT — 3; EGW — 5; FTD — 7; GGR — 1; IDRotF — 2; LLK — 3; SatO — 2; SCC — 5. Подтверждён настоящий рабочий каталог из 514 заклинаний; дополнительного seed не выполнялось.

## 3. Pending migrations

Относительно входного `migration_registry.txt` **pending migrations отсутствовали**. В частности, spell-cast-sources уже была applied, поэтому повторно вручную не применялась.

После генерации новой миграции единственной pending стала `20261006233630830-spell-reference-key-integrity`.

## 4. Применённые миграции

Создана и применена только `20261006233630830-spell-reference-key-integrity`:

```powershell
# Из characters_mirror_server
serverpod generate
serverpod create-migration --force --tag spell-reference-key-integrity
dart run bin/main.dart --mode development --role maintenance --apply-migrations
```

Первый вызов create-migration без `--force` остановился на предупреждениях NOT NULL / UNIQUE. После отдельного разрешения пользователя повторный вызов создал миграцию. Maintenance runtime сообщил `Applied database migration: 20261006233630830-spell-reference-key-integrity` и завершился с exit 0. Применения repair migration не было.

## 5. Результат SQL-аудита после миграции

Latest project migration совпадает с последней строкой registry: `20261006233630830-spell-reference-key-integrity`. Ошибок migration run не было.

`information_schema.columns`: `spell_data.referenceKey`, type text, **is_nullable = NO**, без SQL default; `characters.currentPactSlots`, type json, is_nullable = YES.

`pg_indexes`:

```sql
CREATE UNIQUE INDEX spell_reference_key_idx
ON public.spell_data USING btree ("referenceKey");
```

SQL export всех SpellData, классов, подклассов, class/subclass features, class grants, choice options/groups сравнен до и после: данные идентичны, включая keys, descriptions, shortDescription и timestamps. Количества selections, race grants и slot progressions также сохранены.

## 6. ReferenceKey hardening и совместимость

В `.spy.yaml` поле объявлено `String, defaultModel=''`, unique index — декларативно. `defaultModel` сохраняет optional constructor argument для старых UI fixtures и временных snapshots; **не добавляет SQL default и не генерирует canonical identity**. Generated Dart обновлён исключительно `serverpod generate`.

Новая migration SQL под блокировкой таблицы проверяет NULL, пустые/whitespace-only и duplicate keys **до DDL**, бросает понятное исключение и откатывает транзакцию при нарушении. Значения ключей не изменяются. Проблемных dev rows для классификации/ручного решения нет.

SpellDataEndpoint add/upsert проверяют ключ через централизованную `Rules.shortText`, отклоняют пустые и padded keys. SQL constraints обеспечивают NOT NULL / UNIQUE; пустота дополнительно проверяется guard при миграции и endpoint при записи. CHECK constraint на пустоту не добавлялся.

У текущей Serverpod версии `defaultModel` сам по себе не делает `fromJson` терпимым к отсутствующему полю. Поэтому добавлена узкая совместимость **чтения локального offline cache**: старый отсутствующий/null spell key получает пустой sentinel в копии JSON. Имена, описания, другие reference keys и сохранённый JSON не переписываются. Свежий HTTP reference catalog должен передавать canonical ключи; аудит подтвердил это для всех 514 dev rows.

Аудит consumers обнаружил legacy name fallback в `spell_selection_support.dart`, `persistence_normalization.dart`, `persistence_relation_write.dart` и sorting fallback в `normalization_sorting_includes.dart`. Они сохранены для старых selections; на актуальном каталоге заполненный referenceKey делает name fallback ненужным. Новый resolved/cast pipeline разрешает ID/referenceKey через canonical catalog, не создаёт keys из display name. Использование name для заголовка, сортировки и отображаемого имени концентрации остаётся presentation behavior.

## 7. Spell grants audit

ClassSpellGrantData: **50**, все `alwaysPrepared=true`; orphan spell/source references **0**, invalid keys **0**, duplicate grants **0**, invalid/null grantedAtLevel **0**. Все уровни в диапазоне 1–20. Conditional grants **16**, missing choice options **0**; соответствие sourceSubclassFeature у options/groups и grants проверено, mismatches **0**.

Состав: Cleric Domains — 28 записей (уровни класса 1 и 3), Paladin Oaths — 6 (уровень 3), Land Druid — 16 (уровень 3, по две записи для каждого из восьми terrain choices). Это существующее покрытие данных, полнота таблиц высших уровней в этой задаче не расширялась.

Choice options содержат **116 spell key references**, все разрешаются. Повторения ключей в разных options/groups не являются duplicate grants одного источника. `pact_chain → find_familiar` находится в choice option, а не отдельной ClassSpellGrantData row. Дополнительно проверены **6** class/subclass feature spell key references — orphan keys **0**.

RaceFeatureSpellGrantData: **0**. Поэтому orphan/duplicate rows отсутствуют; распределения castingAbility, freeCastsPerRest, freeCastsFormula, castAtSpellLevel и canAlsoCastWithSpellSlots пустые. Никаких racial grants из текстов не создавалось; поведение race grant проверено integration fixture.

Реальный каталог прошёл pure resolver audit: **514 rows × 4 contexts**, **50 class grants** с canonical class casting source, **116 choice key references** с источником из реальных class/features/groups. Отдельно проверен typed путь `SpellData.fromJson → toJson → SpellPresentationResolver` для всех **514** строк.

Sample matrix: damage `acid_splash`; healing `healing_word`; save `vicious_mockery`; attack `chill_touch`; concentration `friends`; ritual `illusory_script`; AoE `thunderwave`; utility `unseen_servant`; long description `teleport` (5230 символов); cantrip growth fallback `acid_splash`; slot upcast fallback `hellish_rebuke`; granted `bless`. Выбор samples основан на полях, без spell-specific branches.

В dev rows **нет damageScaling и damageParts**. Поэтому на настоящих данных вычисленный caster-level/slot-level scaling проверить невозможно: показываются base formula, metadata, higherLevel/full description; upcast formula помечается как базовая. Structured scaling проверен существующими shared/widget tests на fixtures. **382** строки спокойно используют metadata + description без highlights. Все 514 shortDescription отсутствуют; fallback сохраняет полный текст, массовое заполнение не выполнялось.

## 8. Migration snapshots

В registry порядок хронологический, повторов нет. Весь хвост от feature-choice-links через level3 backfills / feature-presentation / descriptions / deflect / spell-cast-sources проверен на пять ожидаемых файлов.

В трёх directories отсутствовали `definition.json` и `definition_project.json`:

- `20261006206000000-choice-option-short-descriptions`
- `20261006207000000-level3-class-feature-short-descriptions`
- `20261006208000000-deflect-missiles-presentation`

Их `definition.sql` побайтово совпадает с `20261006205000000-level3-technical-backfill-5/definition.sql`, а migration.sql не содержит schema DDL. Поэтому отсутствующие JSON snapshots скопированы из этого последнего полного snapshot **до pact-column изменения**. Добавлены шесть metadata-файлов; существующие SQL/JSON файлы не переписывались.

Новая hardening migration создана прямо в рабочем server package, без временной копии. После неё `serverpod create-migration --tag spell-integrity-snapshot-check` вернул **No changes detected** (ожидаемый exit 1, новая directory не появилась). Это проверяет согласованность source models и нового snapshot. Все migration-файлы, существовавшие во входном baseline, проверены SHA-256 и остались побайтово неизменными, кроме штатно дополненного registry.

## 9. Verification

Из server/client/shared соответственно `dart analyze` — **No issues found**; из Flutter `flutter analyze --no-pub` — **No issues found**.

Из `characters_mirror_shared`:

```powershell
dart test
dart run tool/audit_spell_catalog.dart C:\Users\Matvey\.codex\.tmp\spell-dev-audit\spell-dev-catalog-result.json
```

Shared tests: **32 passed**. Реальный catalog audit: результаты выше.

Из `characters_mirror_server`:

```powershell
dart test test/spell_progression_test.dart test/spell_selection_identity_test.dart test/proficiency_override_validation_test.dart
dart --packages=.dart_tool/package_config.json C:\Users\Matvey\.codex\.tmp\spell_dev_protocol_audit.dart C:\Users\Matvey\.codex\.tmp\spell-dev-audit\spell-dev-catalog-result.json
```

Unit tests: **17 passed**. Typed protocol audit: **514 passed**.

Из `characters_mirror_flutter`:

```powershell
flutter test test/offline_spell_key_compatibility_test.dart test/offline_cache_database_test.dart test/resolved_spell_pipeline_test.dart test/spell_description_newlines_test.dart test/spell_presentation_widgets_test.dart test/spell_page_test.dart test/fight_page_formatters_test.dart test/level_up_spells_test.dart test/spells_step_test.dart
flutter test test/level_up_spells_test.dart test/spells_step_test.dart test/offline_spell_key_compatibility_test.dart
```

Первый прогон: **86 passed**. После последнего совместимого name fallback уточнения второй: **20 passed**. Полный Flutter suite в этой DB-итерации повторно не запускался; известный level_up_hub AppBar harness failure не изменялся.

Интеграции запускались **только штатным root script**:

```powershell
./scripts/test-integration.ps1 -TestPath test/integration/spell_reference_key_integrity_test.dart
./scripts/test-integration.ps1 -TestPath test/integration/resolved_spell_cast_test.dart
./scripts/test-integration.ps1 -TestPath test/integration/character_sync_semantic_actions_test.dart
./scripts/test-integration.ps1 -TestPath test/integration
```

Для этих запусков временный Python runner устанавливает process-local `SERVERPOD_DATABASE_*` override: `localhost:9090 / characters_mirror_spell_audit_20261007`. Project config/password files не менялись. Отдельная additive test-БД создана из штатного **предыдущего** definition.sql, затем тестовый Serverpod применил новую pending migration обычным путём. Старая загрязнённая `characters_mirror_test` сохранена, её SpellData/characters не копировались и не исправлялись.

Фактические вызовы runner из repository root:

```powershell
python C:\Users\Matvey\.codex\.tmp\spell_isolated_integration.py test test/integration/spell_reference_key_integrity_test.dart
python C:\Users\Matvey\.codex\.tmp\spell_isolated_integration.py test test/integration/resolved_spell_cast_test.dart
python C:\Users\Matvey\.codex\.tmp\spell_isolated_integration.py test test/integration/character_sync_semantic_actions_test.dart
python C:\Users\Matvey\.codex\.tmp\spell_isolated_integration.py test test/integration integration-final
```

Focused результаты: integrity **6 passed** (включая SQL guard против NULL/blank/duplicate, endpoint rejection и реальный DB NOT NULL/UNIQUE); resolved casts **4 passed**; semantic actions **6 passed**.

Первый полный прогон на пустом schema-only test catalog выявил необходимые suite fixtures. В отдельную БД скопированы без преобразования из существующей test-БД **14 backgrounds, 87 связанных equipment entries, 40 slot progression rows**; дополнительно один реальный canonical dev spell `teleport` для typed catalog loading test. Dev-БД при этом только читалась. Background/slot fixtures устранили отсутствие seed, production code для этого не менялся.

Повторная полная suite: **193 passed, 2 failed**, exit 1 — только известный отсутствующий `S3_ENDPOINT` в `character_portrait_endpoint_test.dart` и `object_storage_test.dart`. Других failures нет. Полный лог: `C:\Users\Matvey\.codex\.tmp\spell-dev-audit\integration-integration-final.log`.

`git -c core.safecrlf=false diff --check` — успешно. Formatter запускался только для новых/изменённых небольших handwritten файлов; массового форматирования не было.

## 10. Backup

- Database: `characters_mirror`, localhost:5432.
- Timestamp: **2026-10-07 02:32:33.820638 +03:00**, до любых DB изменений.
- Path: `C:\Users\Matvey\.codex\.tmp\spell-dev-audit\characters_mirror-dev-20261007-023233.dump`.
- Format: `pg_dump -Fc`; exit **0**; размер **2 763 135 bytes**.
- `pg_restore --list` — exit **0**.
- SHA-256: `49de6ad585c1430cd3303bc476ecfa243bb77e392178f6460ae4fdb4feadfe0b`.

Backup и SQL exports лежат вне git. Обычные `pg_dump/psql` arguments содержали только host/port/user/database; password передавался через environment.

## 11. Границы изменений

Production не подключалась. 514 spell descriptions, shortDescription, referenceKey values, grants/reference metadata не изменялись. Массового backfill, combat runtime изменений, DROP/DELETE reference data, reset/recreate существующих БД, Git reset/revert/commit/branch switch не было. Входные unrelated изменения сохранены. Отдельная test-БД оставлена для воспроизводимости проверок.

Automation: обычные inline shell commands и читаемые временные Python/Dart scripts под `C:\Users\Matvey\.codex\.tmp`; соединения только к localhost PostgreSQL/Docker. Browser debug tools и live UI/Marionette session не использовались; widget tests не требовали hot reload/restart.

## 12. Файлы и diff

Основные изменения этой итерации:

- `spell_data.spy.yaml`, regenerated server/client SpellData и generated protocol.
- `spell_data_endpoint.dart`: проверка canonical key при reference write; regression integration test.
- Offline cache compatibility helper/read wiring и три regression tests.
- Минимальные nullable-key adjustments в creation, level-up и racial spell helpers; одна race endpoint fixture получает явный test key.
- `characters_mirror_shared/tool/audit_spell_catalog.dart`: read-only JSON resolver audit.
- Этот отчёт и ссылка из предыдущего refactor report.

Новые/изменённые migration files:

```text
migration_registry.txt                                      modified
20261006206000000-choice-option-short-descriptions/
  definition.json                                         new
  definition_project.json                                 new
20261006207000000-level3-class-feature-short-descriptions/
  definition.json                                         new
  definition_project.json                                 new
20261006208000000-deflect-missiles-presentation/
  definition.json                                         new
  definition_project.json                                 new
20261006233630830-spell-reference-key-integrity/
  migration.sql                                           new
  migration.json                                          new
  definition.sql                                          new
  definition.json                                         new
  definition_project.json                                 new
```

Полный `git -c core.safecrlf=false diff --stat` сохранён в `C:\Users\Matvey\.codex\.tmp\spell-dev-audit\git-diff-stat.txt`. Он включает исходный dirty baseline и не включает untracked новые файлы. Отдельный список файлов, изменённых относительно входного baseline: `incremental-files.json` в той же директории.

```text
Входной tracked diff: 59 files changed, 1765 insertions(+), 1399 deletions(-)
Итоговый tracked diff: 67 files changed, 1835 insertions(+), 1427 deletions(-)
Относительно входных файлов: 14 modified, 16 new (включая отчёт и snapshots)
```
