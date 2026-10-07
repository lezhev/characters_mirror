# Spell presentation / cast: отчёт

## 1. Архитектура

В `characters_mirror_shared/lib/src/spells/` добавлены чистые модели и resolvers без Flutter, BuildContext и проверок конкретных spellKey:

- `SpellPresentation`, `SpellHighlight` и `SpellPresentationContext` — подготовленный контент и контекст вычисления.
- `SpellSourceContext`, `ResolvedCharacterSpell` и `resolveCharacterSpellCollection` — одна запись заклинания с сохранением источников.
- `SpellCastContext`, `SpellSlotPools`, `availableSpellCasts`, `applySpellCast` — выбор и проверка расхода ресурса.
- `spellProtocolIntMap` — адаптер стандартного Serverpod JSON-кодирования карт с числовыми ключами.

Общие resolvers принимают протокольные JSON-данные. Server/client adapters преобразуют результаты в соответствующие generated-модели. Presentation в БД не сохраняется. `ResolvedCharacterSpellData` и `SpellSourceContextData` — сериализуемые derived views; у них нет таблиц.

## 2. Spell card

Общий `SpellCard` используется на sheet, в creation и level-up pickers. Collapsed содержит название, уровень/школу, метаданные и максимум три highlights. Приоритет: damage/healing → attack/save → condition → area → target → scaling notes.

Expanded details и cast preview используют один `SpellPresentationView`: metadata, V/S/M, optional highlights, полный description, higher-level текст и материалы. Полный текст переносится и прокручивается; ellipsis и ограничение числа строк отсутствуют. Нет индивидуальных spell icons, изображений или отдельной палитры; outline и цвета берутся из темы.

Отсутствие structured fields и shortDescription нормально: метаданные и полный description остаются доступны. Curated shortDescription поддержан resolver-ом как opt-in; текущий expanded UI показывает полный текст.

Буквальные `\n` и `\r\n` преобразуются при отображении description, shortDescription, higherLevel, material description и notes. Реальные переносы и русский текст сохраняются. Исходные строки не изменяются.

## 3. Existing SpellData и legacy fields

| Поля | Production contract / fallback |
| --- | --- |
| damageParts / damageDice, damageType, damageScaling | Валидные damageParts имеют приоритет; legacy-поля — fallback. Один shared resolver подключён к карточкам и существующему fight formatter adapter. |
| SpellScalingData | Exact slot-level formulas и caster-level thresholds; special notes сохраняются. Проза higherLevel не парсится. |
| attackType / requiresAttackRoll | Typed attackType, включая `none`, имеет приоритет; bool — fallback при отсутствии типа. |
| savingThrowAbility / requiresSavingThrow | Нормализация характеристик в shared layer; typed ability определяет save highlight, bool покрывает строки без ability. Хранилище String? не мигрировалось. |
| duration / durationType | Читаемый duration используется первым; instantaneous — безопасный fallback. Остальные durationType без текста не позволяют восстановить время. |
| materialDescription / requiresMaterial | Details/cost указывают на M; bool сохраняется как совместимость. Cost отображается в минимальной денежной единице, consumption — явно. |
| isHealing / healingDice | Сохранённая формула лечения. Отдельного healing scaling или поля «добавить casting modifier» в модели нет; они не выдумываются. |
| conditions, targetType, areaOfEffect* | Общие typed highlights с размерами области. |
| concentration, ritual, V/S/M, castingTime, range, schoolValue | Общие metadata/components. |

Если выбран upcast, но эффективную формулу нельзя вычислить, highlight отмечен как базовый, а existing higherLevel остаётся видимым. Temporary HP не выводятся из isHealing. RequiresLineOfSight не получил отдельного highlight; source/version/timestamps остаются provenance/storage metadata. Class/subclass availability используется существующими selection flows.

Удаление дублирующих полей, изменение String savingThrowAbility на enum и прочий schema cleanup оставлены отдельными задачами.

## 4. Grants

Server и offline строят resolved collection из selections, текущих class/subclass feature grants, eligible ChoiceOption grants, conditional ClassSpellGrantData и racial grants. Canonical SpellData загружается из reference rows/cache; поддержаны ID-only selections. GrantedAtLevel проверяется отдельно от уровня racial feature.

Generated `CharacterDerivedData.resolvedSpells` доставляет на sheet сами заклинания и источники, а не только ключи. Fake persisted selections не создаются. Изменение уровня/источника/выбора пересчитывает grants. При отсутствии класса attributed selection не превращается в anonymous source.

Старые key aggregates сохраняются для совместимости с существующими consumers. Старые cached snapshots без resolvedSpells имеют selection-based fallback до следующего resolver refresh; этот fallback не может восстановить отсутствующие reference rows для grants.

## 5. Multiple sources и preparation

Один canonical referenceKey даёт одну карточку. Class selection и grant одного класса объединяются; разные классы и racial sources сохраняются. Источники упорядочены по class order и source key. Entry identity имеет приоритет над противоречащим classDataId.

Casting ability определяется от своего class/subclass либо explicit racial grant. При нескольких кастерах для unattributed legacy selection первая ability не подставляется. Header показывает отдельные class stats; карточка и cast preview используют релевантный/выбранный source.

Prepared selections учитываются по источникам. Снятие подготовки удаляет prepared row только выбранного класса, сохраняя Wizard book row и подготовку другого класса. Persisted preparedSpellKeys остаётся совместимым агрегатом; новое source разрешение не делает Wizard book подготовленным только из-за Cleric preparation.

## 6. Cast и Pact Magic

Production cast UI выбирает source, standard/pact pool и доступный уровень >= base spell level. Equivalent source choices объединяются только при одинаковой ability, pool и cast level. Preview пересчитывается до расхода. Cantrip использует no-slot context.

Запрос передаёт spellKey/sourceKey/slotSource/castLevel. Сервер получает правила и concentration name из canonical derived spell, проверяет доступность источника и ресурса; клиентские концентрационные metadata не подменяют canonical правила. Server и offline используют один shared apply/validation contract.

Pact расходуется через `currentPactSlots`; standard — через `currentSpellSlots`. Short/long rests восстанавливают pact отдельно. Sync revisions, barrier targets, persistence, replay и level-change preservation учитывают оба поля. Level change не считается отдыхом.

Старый combined counter не содержит историю происхождения расхода. При первом изменении он разделяется детерминированно: оставшиеся standard сначала, pact — остаток. Общее оставшееся количество сохраняется, потраченные ячейки не восстанавливаются. Ненулевой pact map помечает уже разделённый snapshot.

## 7. Что не автоматизировано

Cast меняет только выбранные ячейки и существующую концентрацию. HP, temporary HP, conditions, targets, movement, saving throws цели, AoE, summons/familiars и combat runtime не применяются. Существующий caster attack roll и сообщение о save DC сохранены.

Racial freeCastsFormula/freeCastsPerRest/castAtSpellLevel сохраняются в source metadata, но отдельного счётчика free casts нет. Slot permission учитывается через canAlsoCastWithSpellSlots. Ограниченные racial cantrips не превращаются в unlimited no-slot automation. Источники choice без надёжных casting/slot metadata показываются, но слотные casts для них не выдумываются. Mystic Arcanum и runtime spell modifiers не добавлялись; context уже содержит caster/cast level, ability/modifier, attack/DC для следующего слоя.

## 8. Reference key preflight и миграция

Доступная тестовая база: 134 строки, NULL keys = 0, пустые keys = 134, duplicate empty key = 134. Список IDs: `.tmp/spell-reference-key-preflight.csv`. Dev PostgreSQL после временного запуска оказался пустым и на миграции `20260501050439998`, без referenceKey column. Контейнер затем остановлен. Исходный каталог из 514 строк здесь недоступен; unique/non-null constraint не добавлен, ключи автоматически не создавались.

Новые consumers используют canonical referenceKey, включая mapping ID-only и legacy selection keys через reference row. Name fallback в низкоуровневой legacy persistence и `spellReferenceKey` для строк без canonical key оставлен для отдельной cleanup задачи.

Миграция `20261006223316590-spell-cast-sources` добавляет только nullable JSON column `characters.currentPactSlots`. DROP/DELETE/backfill SpellData отсутствуют. Она применена тестовым сервером; к dev/production не применялась.

Первый `serverpod create-migration --tag spell-cast-sources` из server package остановился: у последнего existing backfill нет definition_project.json. Проверено, что после последнего полного snapshot нет DDL. В временной копии проекта восстановлены только snapshot metadata; CLI создал новую миграцию. В репозиторий перенесены новая версия с полными definitions и запись registry. Старые applied migrations не менялись. `--force` не использовался.

## 9. Проверки

- `serverpod generate` из server package — успешно; generated Dart вручную не редактировался.
- `dart analyze` в server, client и shared; `flutter analyze --no-pub` — без замечаний.
- Shared `dart test` — 32 passed.
- Server `dart test test/spell_progression_test.dart test/spell_selection_identity_test.dart test/proficiency_override_validation_test.dart` — 17 passed.
- `./scripts/test-integration.ps1 -TestPath test/integration/resolved_spell_cast_test.dart` — 4 passed: grants/multiple sources, upcast/pact/no healing, selection deduplication, racial level/ability metadata.
- `./scripts/test-integration.ps1 -TestPath test/integration/character_sync_semantic_actions_test.dart` — 6 passed.
- Полный `./scripts/test-integration.ps1` — 187 passed, 2 failed только из-за отсутствующего S3_ENDPOINT: portrait и object_storage. Это отдельный environment gap.
- Widget матрица: 18 механически разных fixtures, collapsed/expanded на 320 px, полные абзацы и отсутствие overflow; ещё 2 tests проверяют cast chooser и switching casting ability. Команда: `flutter test test/spell_presentation_widgets_test.dart --no-pub --dart-define=SPELL_UI_SCREENSHOTS=true` — 20 passed.
- Focused Flutter pipeline/state + selection + sheet: `flutter test test/resolved_spell_pipeline_test.dart test/spell_selection_stage1_test.dart test/spell_page_test.dart --no-pub` — 26 passed.
- Creation/level-up и spell widgets: targeted прогон шести spell-related test files — 51 passed до добавления дополнительного controller regression test; subsequent targeted controller suite прошёл.
- Полный `flutter test --no-pub` — 684 passed, 1 skipped, 1 failed: `level_up_hub_test.dart`, `short hub starts directly under app bar and keeps multiclass in class card`, строка 308. Finder ожидает AppBar, которого нет в harness. Этот test/hub уже находился во входном изменённом дереве и мной не менялся. Ошибка воспроизводится отдельным `flutter test test/level_up_hub_test.dart --no-pub --plain-name 'short hub starts directly under app bar and keeps multiclass in class card'`. Все spell-related failures из первого полного прогона исправлены.
- `git -c core.safecrlf=false diff --check` — успешно.

До исправлений meaningful red tests воспроизвели буквальные newlines, per-source preparation, removed class attribution, ID-only/legacy identity, entry identity priority, limited free cantrip и multiclass unprepare. После исправлений они зелёные.

Снимки widget harness: `.tmp/spell-refactor-collapsed-320.png`, `.tmp/spell-refactor-expanded-320.png`; они просмотрены визуально. Live app/Marionette session не запускалась, hot reload/restart не использовались. Automation использовала обычные shell commands, читаемые временные Python scripts под `C:\Users\Matvey\.codex\.tmp`, локальные Docker/PostgreSQL и Flutter tests; внешние сетевые подключения и browser debug tools не использовались.

## 10. Файлы и данные

Основные изменения:

- `characters_mirror_shared/lib/src/spells/` и shared exports/tests.
- Flutter `core/character_spells/{character_spell_projection,spell_cast_application,spell_selection_support}.dart`.
- Flutter offline resolver/replay/semantic sync/diff и новый `offline_character_resolver/resolved_spells.dart`.
- Character sheet state spell/rest helpers, spell page/card/details и новые `spell_presentation_view.dart`, `spell_cast_dialog.dart`, `spell_source_stats.dart`.
- Server derived spells/reference cache, cast service, persistence/validation/sync targets/rest/level-change preservation.
- CharacterData/Record/Derived/SemanticAction `.spy.yaml`, два новых view models, regenerated server/client protocols.
- Одна additive migration и registry.
- Новые fixtures/tests; минимально обновлены metadata assertions в уже изменённых пользователем `level_up_spells_test.dart` и `spells_step_test.dart`.

Существующие SpellData descriptions массово не переписывались. Spell shortDescription не генерировались. Ни один из 514 catalog rows не был автоматически «улучшен». Reference data backfill и destructive schema cleanup не выполнялись. Исходные незакоммиченные изменения сохранены; commits/branch changes/reset/revert не выполнялись.

Продолжение от 2026-10-07: настоящая PostgreSQL 17 development БД на 5432 проверена, сделан backup, применён referenceKey NOT NULL / UNIQUE hardening и восстановлены отсутствующие migration snapshots. Подробности и результаты проверок: [spell-development-database-audit.md](spell-development-database-audit.md).
