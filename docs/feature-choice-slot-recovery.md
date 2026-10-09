# Условные grants, восстановление ячеек и presentation фич

Работа завершена в рабочем дереве без коммита. КД «Драконьей устойчивости» использует существующие `FeatureModifierData`, evaluator и общий armor-class resolver. Отдельного расчёта для чародея нет.

## Поведение

«Улучшенная малая иллюзия» использует общие `ChoiceGroupData`, `ChoiceOptionData` и `CharacterChoiceData`. Автоматический вариант выдаёт `minor_illusion`, когда заговор ещё не известен. Если он уже известен, нужен явный выбор другого доступного заговора волшебника, даже когда остался один вариант. Requirements учитывают обычные selections, другие grants и расовые источники. Grant не добавляет запись в `spellSelections` и не расходует обычную квоту заговоров.

Фактически полученный заговор отображается через `selectedChoiceDetails`. Сервер сохраняет автоматический выбор и проверяет новые варианты по каноническим данным. Уже полученный выбор сохраняется при появлении другого источника того же заговора. Понижение уровня убирает choice/grant потерянной фичи, сохраняя заклинания из остальных источников; поддержаны и старые choices без привязки к class entry.

Восстановление ячеек выполняется одной semantic operation `recoverSpellSlots`. Shared policy проверяет источник фичи, effect ID, pool, ресурс, настоящий trigger, потраченные ячейки и канонический максимум. Изменения ячеек, расход ресурса и потребление trigger входят в один patch, который сервер сохраняет транзакционно. Replay использует ту же shared логику.

| Фича | Policy | Pool | Trigger | Использование и сброс |
| --- | --- | --- | --- | --- |
| Arcane Recovery | Сумма уровней ≤ ceil(уровень волшебника / 2), максимум 5 | standard | shortRest | `arcaneRecovery`, 1, dawn |
| Natural Recovery | Сумма уровней ≤ ceil(уровень друида / 2), максимум 5 | standard | shortRest | `naturalRecovery`, 1, longRest |
| Expert Divination | Ровно одна ячейка ниже фактического cast level, максимум 5 | standard | Успешный Divination cast через ячейку 2+ | Без отдельного ресурса |
| Eldritch Master | Все потраченные ячейки, без выбора | pact | manual, длительность в policy 60 секунд | `eldritchMaster`, 1, longRest |

Общий modal picker показывает потраченные ячейки, ограничивает количество и бюджет, блокирует пустое подтверждение. Cast flow предлагает Expert Divination после успешного расхода подходящей ячейки. Кнопка фичи недоступна, когда восстанавливать нечего. Для Arcane Recovery есть действие «Новый день». После нового дня или следующего cast закрывается прежняя возможность восстановления от короткого отдыха. Обычные long-rest standard restore и short-rest Pact Magic restore сохранены; `RestType.special` по-прежнему не является исполняемым отдыхом.

События восстановления хранятся в серверном `spellRecoveryTriggers`: произвольный snapshot не может их создать. Barrier tokens защищают от устаревшего trigger, пересечения с reset/correction и повторного расходования. Сохранены разделение standard/pact pools и материализация legacy combined counters. Сервер объявляет sync protocol 5; новая recovery operation требует 5, прежние semantic operations продолжают принимать protocol 4.

Общий presentation resolver отображает HP, AC и spell-healing modifiers отдельными свойствами. Он использует существующие structured values и evaluator, без feature-key branches. «Поборник жизни» показывает `Уровень ячейки + 2 (от 1-го уровня)`, чародей — дополнительный максимум хитов и формулу КД без доспехов. «Гнев бури» сохраняет ресурс, `max(1, WIS)`, long-rest reset и свойство `2к8`.

## Модели

Новые source definitions:

- `SpellSlotRecoveryMode`: `levelBudget`, `singleLowerLevel`, `all`.
- `SpellSlotRecoveryPolicyData`: режим, resource key, бюджет по уровню источника, максимальный slot level, минимальный cast level, школа и длительность активации.
- `SpellSlotRecoveryTriggerData`: ID породившей операции, trigger и cast level.

Добавленные поля:

- `ChoiceRequirementData.negate`.
- `ChoiceGroupData.autoSelectSingleEligible`, `ChoiceOptionData.automaticSelection`.
- `FeatureResourceEffectData.recoveryPolicy`.
- `CharacterFeatureViewData.sourceClassLevel`, `spellSlotRecoveryEffects`.
- `CharacterSemanticActionData.recoveryEffectId`, `slotsToRestore`, `recoveryTriggerId`; существующие source identity/resource/pool поля переиспользованы.
- `CharacterData` и серверный `CharacterRecord.spellRecoveryTriggers`.
- Enum values `CharacterSyncOperationType.recoverSpellSlots`, `FeatureResourceTrigger.spellCast`.

Server/client protocol bindings получены через `serverpod generate`, вручную не редактировались.

## Миграции и dev-БД

Добавлены и применены:

- `20261007182600000-feature-choice-slot-recovery`: nullable schema fields, conditional choice group/options, четыре recovery policies, ресурс Eldritch Master, исполняемый daily reset Arcane Recovery и пять дословных short descriptions из задания.
- `20261007182700000-conditional-grant-selection`: nullable `automaticSelection` и автоматический признак только у варианта `minor_illusion`.

В dev-БД группа содержит 30 вариантов по каноническому списку Wizard cantrips. Только фича Improved Minor Illusion теряет свой прежний безусловный grant, если он существует. Полный текст «Поборника жизни» исправлен единственной заменой `заклинание ? 1-го` → `заклинание 1-го`.

Сравнение снимков до/после подтвердило полное сохранение существующих строк `feature_modifier_data` и всей строки фичи Wrath of the Storm, включая тексты. До применения сделан и проверен `pg_dump -Fc` dev-БД. Пользовательская миграция `20261007182500000-subclass-level2-presentation` сохранена.

Команды Serverpod из server package:

```text
serverpod generate
serverpod create-migration --tag feature-choice-slot-recovery
serverpod create-migration --tag conditional-grant-selection
dart run bin/main.dart --mode development --role maintenance --apply-migrations
```

Версии новых, ещё не применённых миграций упорядочены после уже существующей `1825` перед применением к dev-БД. Изолированный test run успел применить промежуточное имя второй миграции. Его историю восстановили штатно:

```text
serverpod create-repair-migration --version 20261007182700000-conditional-grant-selection --mode development --tag test-history
dart run bin/main.dart --mode test --role maintenance --apply-repair-migration
```

Обе repair-команды были направлены переменными окружения только в `characters_mirror_spell_structured_20261007` на `127.0.0.1:9090`. Проверенный repair SQL содержал только migration-version upserts, без schema/data changes. SQL сохранён в `C:/Users/Matvey/.codex/.tmp/feature-completion/20261007212351988-test-history.sql`; временный сервер остановлен.

## Проверки

- `dart test` в shared: 61 тест прошёл.
- Финальный `flutter test`: 741 тест прошёл, 2 проверки server-snapshot exports пропущены без соответствующих environment variables. Исправлен устаревший selector теста `level_up_hub_test.dart`: он теперь использует фактический `PageSizeAppBar`, без изменения UI.
- После последних изменений creation/rest выполнен дополнительный Flutter-прогон 46 тестов: conditional choices, creation widgets, основной app flow, rests, recovery dialog и feature presentation — прошёл.
- `dart analyze` в shared/server/client и `flutter analyze`: без замечаний.
- Backend integration запускаются исключительно через корневой `scripts/test-integration.ps1 -TestPath ...`.
- Повторить полный backend прогон после настройки существующего S3 окружения: `powershell -NoProfile -File scripts/test-integration.ps1 -TestPath test/integration` из корня репозитория.
- Полный backend прогон: 207 тестов прошли; из трёх обнаруженных сбоев исправлено сохранение прежнего запрета `RestType.special`, затем `character_sync_semantic_actions_test.dart` повторно прошёл все 6 тестов. Два независимых storage/portrait теста требуют не заданный в окружении `S3_ENDPOINT`.
- Conditional grant integration: создание, обязательный выбор, запрет дубликатов, class grants, сохранение acquired choice, level-up и level-down — 5 тестов прошли.
- Feature spell/HP integration: Life, Draconic и Wrath — 3 теста прошли.
- Recovery integration: 5 тестов прошли; проверены budgets, запрет 6+, потраченные ячейки, атомарный расход, dawn/long-rest reset, реальный cast, lower-level single recovery, pact-only recovery и crossed barriers.
- Реальные серверные операции экспортированы для проверки Flutter replay, включая runtime state и barrier tokens; проверка запускалась с `FEATURE_COMPLETION_REPLAY_SNAPSHOTS` и прошла оба теста `spell_slot_recovery_replay_test.dart`.
- `git diff --check` выполнен.

## Основные файлы

Shared:

- `characters_mirror_shared/lib/src/choice_eligibility.dart`, `choice_protocol.dart`.
- `characters_mirror_shared/lib/src/feature_modifier_display_properties.dart`, `feature_modifier_protocol.dart`, `armor_class_resolver.dart`.
- `characters_mirror_shared/lib/src/spells/spell_slot_recovery.dart` и exports.

Server:

- `choice_eligibility_context.dart`, `feature_display_properties.dart`.
- `character_data_endpoint/derived_automatic_choices.dart`, `derived_source_resolution.dart`, `normalization_basic_features.dart`.
- `character_data_endpoint/sync_semantic_actions.dart`, sync validation/application/revisions, aggregate and persistence adapters.
- `character_data_endpoint/level_up_choices.dart`, `level_up.dart`, `level_down.dart`.
- `class_endpoints/class_write_helpers.dart`, endpoint protocol/capabilities.
- `.spy.yaml` source definitions, generated bindings, две новые миграции и registry.

Flutter:

- `core/character/conditional_choice_support.dart`, `core/character_spells/spell_slot_recovery_application.dart`.
- Offline resolver, conditional choices/feature helpers, semantic operations и replay.
- `reference_character_repository.dart`: semantic sync сохраняется и при отсутствии offline store.
- Creation class choices и level-up eligibility/selected choice presentation.
- `character_sheet_state/spell_recovery_operations.dart`, feature resources, обычные feature cards и rest/cast flow. «Новый день» сохраняет оба slot pool; отдельные controller-тесты проверяют это и запись short-rest recovery event без автоматического восстановления standard slots/daily uses.
- `spell_slot_recovery_dialog.dart`, `spell_slot_recovery_actions.dart`, `spell_slot_recovery_flow.dart`.
- Shared, Flutter и server tests для новых механизмов; существующие sync protocol assertions обновлены до ответа версии 5.

## Сохранённые ограничения

Одновременные звук и изображение Minor Illusion остаются runtime/reference-only; личный `SpellData` не изменяется. Font of Magic не включён. Длительность Eldritch Master хранится и отображается как игровое условие ручного действия, без отсчёта реальной минуты. Проверка UI выполнена widget-тестами; отдельный ручной браузерный прогон не выполнялся.

Автоматизация использовала короткие PowerShell-команды и прозрачные временные Python-скрипты в `.codex/.tmp/feature-completion`. Подключения к PostgreSQL/Insights были локальными; секреты не включались в команды, отчёт или снимки. Коммиты и PR не создавались.
