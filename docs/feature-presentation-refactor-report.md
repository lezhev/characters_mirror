# Рефакторинг feature presentation — 6 октября 2026

## 1. Общий presentation contract

`FeaturePresentation` хранит имя, shortDescription, display properties, связанные решения и resource summaries. `ChoiceGroupPresentation` хранит title, minimum/maximum, required/optional semantics, selected keys, completion state, options с shortDescription и eligibility reason, а также inline/picker mode. Builders не зависят от Flutter widgets или BuildContext.

Creation и level-up используют общие `FeatureSummary`, `ChoiceDecision` и `ChoicePicker`. Sheet использует существующий `CharacterFeatureViewData`, дополненный структурированными данными выбранных options и отдельным полем для отображаемого короткого текста. Один универсальный экранный widget не создавался.

## 2. Объединённые и удалённые реализации

- Отдельные creation choice surfaces для feature-backed groups заменены решениями внутри feature card.
- Level-up singleton feature cards и private feature/choice card заменены одной `LevelUpFeatureSection` с Divider между features.
- Picker перенесён в общий UI. Прежние `LevelUpPicker` и `LevelUpPickerOption` сохранены как aliases; spell screens продолжают использовать тот же picker и прежние лимиты.
- ASI/feat wiring извлечён из Hub в `LevelUpAsiDecision`; операции controller сохранены.
- Мёртвый `related_feature_tables.dart` удалён после проверки отсутствия consumers. Его независимый formatter для escaped newlines сохранён в `feature_text.dart`.

## 3. Связь Feature + ChoiceGroup

Используются только `sourceFeatureId` и `sourceSubclassFeatureId`, с отдельными namespaces class/subclass. Связь поддерживает несколько groups у одной feature. Legacy `choiceGroupKey` и русские имена не используются для связи. Groups без отображаемой source feature остаются доступными самостоятельными решениями.

Level-up собирает features в порядке данных и уровня, независимо от порядка choice groups. Существующая feature возвращается в секцию, если у неё появилось новое решение или новый resource. Resource из derived snapshot также остаётся внутри своей feature, если её нет в target class step, например при другом multiclass source.

Для subclass unlock добавлена nullable canonical-ссылка `ClassData.subclassChoiceFeatureId`, проецируемая в `ClassStepSubclassChoiceView.sourceFeatureId`. Сервер проверяет принадлежность feature классу и совпадение unlock level. Без ссылки picker остаётся доступным отдельным решением. Параллельные пользовательские backfill-миграции заполняют эту ссылку; их SQL в рамках этой работы не изменялся.

## 4. Duplicate group title

Сравнение для отображения нормализует регистр, внешние и повторяющиеся пробелы, не меняя сохранённые строки. Совпадающий title скрывается. Единственный typed catalog decision — fightingStyle, invocation, expertise, abilityIncrease или feat — уже именуется owning feature, поэтому его второй catalog title тоже скрывается. Несколько groups сохраняют различающие titles, кроме точного дубля feature title. Refinement вроде «Тип врага» сохраняется.

Это presentation policy по типу решения, без class names, reference keys или поиска source feature по русскому названию.

## 5. Creation и level-up mandatory presentation

Creation показывает нейтральное «Выберите N», диапазон или «До N». Picker допускает завершение неполного выбора. Явного «Обязательно» и error цвета из-за незаполненного решения нет.

Level-up показывает «Обязательно · выбрать N» либо «Необязательно · до N», а также состояние выбранного количества/варианта. Apply по-прежнему управляется существующим server preview/controller contract. ASI остаётся inline, feat/subclass — picker, spells — отдельные screens.

## 6. Выбранные options на sheet

`SelectedFeatureChoiceView` содержит groupKey/groupTitle, optionKey, name и shortDescription. Сервер формирует DTO из уже разрешённых canonical options. Offline resolver формирует те же данные из cache по group/option IDs и keys. Lookup по имени и reference fetch в widget tree отсутствуют.

`selectedChoices: List<String>?` сохранён для совместимости, но новый sheet читает `selectedChoiceDetails`. На sheet видны только name и shortDescription результата выбора, без group prompt, min/max и mandatory markers. Общая fixture проверяет server/offline parity для class и subclass feature, нескольких groups и отсутствующего option shortDescription. Есть cache/serialization roundtrip и чтение старого payload.

Обычный reference text берётся из нового short field. Явный пользовательский description override проецируется туда же. Старые `description/defaultDescription` сохранены для edit dialog и прежнего сравнения customization/defaults: это исключение для editing UX, а не UI fallback на длинный reference text.

## 7. Protocol и schema

Добавлены nullable поля:

- `ChoiceOptionData.shortDescription` и `SubclassData.shortDescription` — до рефакторинга их не было в модели.
- `ClassData.subclassChoiceFeatureId` — FK на class feature.
- `CharacterFeatureViewData.shortDescription`, `selectedChoiceDetails`.
- `ClassStepFeatureView.resources`.
- `ClassStepSubclassChoiceView.sourceFeatureId`.

Добавлен DTO `SelectedFeatureChoiceView`. Выполнен `serverpod generate`; generated bindings вручную не редактировались. `serverpod create-migration --tag feature-presentation` создал additive migration без DROP/DELETE.

Собственная миграция получила итоговый ID `20261006203500000-feature-presentation`: она стоит между пользовательскими backfill-3 и backfill-4, которым нужна новая колонка. Registry пересоздан штатным `MigrationRegistry` из установленного serverpod_cli. Проверено, что более поздняя пользовательская definition snapshot тоже содержит новые columns.

Миграция применена server runtime при integration tests только к тестовой БД. Production schema этой работой не изменялась. Старые payloads десериализуются; старому derived cache нужно обновление/re-resolution, чтобы получить новые short/details поля.

## 8. relatedTable

Поле сохранено в reference models/БД. Creation, sheet и level-up его не рендерят и не парсят. Удалён только неиспользуемый UI/parser файл.

## 9. Tags/icons

Feature tag icons сохранены на sheet. Creation и level-up их не выводят. FeatureTag и metadata в модели сохранены; class catalog images и обычные choice check/chevron icons не менялись.

## 10. Display properties

Во всех трёх контекстах используется существующий `FeatureDisplayProperties`. Level-up получает свойства из ClassStep feature views, с derived snapshot как дополнительным источником. Частичный view payload больше не исключает feature rows без отдельной property view. Server population и cached offline projection проверены тестами.

## 11. Resources

- Creation: компактные name/max/reset summaries внутри feature. Учитываются reference max rules, текущие ability modifiers и выбранные canonical option IDs.
- Sheet: существующие current/max controls, reset metadata и callbacks сохранены.
- Level-up: показаны только впервые появившиеся resource keys. Обычные max changes скрыты. Несколько новых resources принадлежат одному feature presentation, а не отдельным notices.

Оценка max для reference summary вынесена в shared helper; authoritative resource mechanics и effects не изменялись.

## 12. Subclass display name

Один shared `subclassDisplayName` используется в creation, summary, subclass picker, level-up, sheet details и server/offline source labels. Он объединяет существующие `subclassName` и `name`, не склоняет слова и не добавляет model metadata для названия. Уже составное имя не получает повторный prefix. Тесты покрывают «Школа ограждения», «Клятва преданности» и «Круг Луны».

## 13. Reference-data gaps

Массовый content backfill не выполнялся. Новые nullable option/subclass shortDescription columns не заполняются копированием full description. Все существующие rows без short text требуют отдельного содержательного backfill; Fighting Style и другие feature-backed catalogs должны получить короткие описания из reference data.

Read-only audit на локальной тестовой БД после suite показал:

| Тип | Rows | Без shortDescription |
| --- | ---: | ---: |
| ClassFeature | 4 | 4 |
| SubclassFeature | 0 | 0 |
| ChoiceOption | 266 | 266 |
| Subclass | 8 | 8 |

Четыре feature rows: «Воинский Архетип», «Второе Дыхание», «Всплеск Действий», «Боевой Стиль», все без referenceKey. Восемь subclass rows тоже без canonical referenceKey. Class/subclass choice groups в этой тестовой БД отсутствуют: 266 options относятся к другим seeded catalogs. Поэтому эти числа не являются аудитом рабочего PHB-каталога и не доказывают наличие всех Ranger/Warlock/Fighter rows на рабочем сервере.

Для рабочего каталога подготовлен `docs/feature-presentation-data-audit.sql`: он перечисляет missing feature/option/subclass short text и отсутствующие/некорректные subclass source links. SQL проверен на тестовой БД, внешняя БД не опрашивалась.

В existing test reference data обнаружены имена options, сохранённые как question marks, например `criminal_gaming_set / dice_set`: UTF-8 hex `3f3f3f3f3f`. Это отдельная data/encoding проблема. Исходные файлы и эти rows не переписывались; для восстановления нужны правильные canonical reference values.

## 14. Файлы

Полный список файлов данной работы приведён в приложении ниже. Пользовательские `.tmp/` файлы и reference-data backfill migrations в список изменений этого рефакторинга не включены. Shared migration registry содержит как нашу schema migration, так и параллельные пользовательские entries.

## 15. Тесты

Новые Flutter suites:

- `feature_presentation_regression_test.dart`: no full fallback, required/optional decision state, единая outline section.
- `feature_presentation_contract_test.dart`: one/multiple groups, title suppression, selected descriptions, tags, display properties, resource summary, subclass composition, Expertise eligibility, incomplete creation picker и замена полного выбора.
- `level_up_feature_composition_test.dart`: Barbarian/Bard/Paladin/Ranger 1→2, reference order, class/subclass namespaces, selected option resource summaries и скрытое resource scaling.
- `selected_feature_choice_parity_test.dart`: server/offline fixture contract, class/subclass, cache roundtrip, old payload.

Новый backend `integration/feature_presentation_test.dart` проверяет тот же selected-choice contract, ClassStep source linkage, display properties и resources. Общая fixture — `test_fixtures/selected_feature_choice_contract.dart`.

Обновлены существующие assertions/fixtures для class features, sheet card, subclass navigation, creation choices, level-up choices/Hub/overview. Choice persistence/controller tests и остальные existing creation/sheet tests выполнены в полном suite.

До production edits четыре регрессионных assertions упали по ожидаемым причинам: full-description fallback, отсутствие двух mandatory/optional labels и separate feature outlines. После изменений эти тесты прошли. Дополнительно сначала воспроизведён пропуск нового resource при отсутствующей ClassStep source feature, затем исправлен builder и проверен зелёный тест.

## 16. Проверки и результаты

Из `characters_mirror_server`:

```powershell
serverpod generate
serverpod create-migration --tag feature-presentation
dart analyze
dart test test/admin_endpoint_contract_test.dart test/choice_eligibility_test.dart test/choice_eligibility_context_test.dart test/development_log_profile_test.dart test/feature_display_properties_test.dart test/proficiency_override_validation_test.dart test/spell_progression_test.dart test/spell_selection_identity_test.dart test/weapon_training_schema_test.dart
```

Generation завершилась успешно; analyze без issues; 34 unit tests прошли. После финальной генерации повторён analyze изменённых server files и нового integration test — без issues.

Из корня репозитория:

```powershell
./scripts/test-integration.ps1 -TestPath test/integration/feature_presentation_test.dart
./scripts/test-integration.ps1
git diff --check
```

Новый integration suite: 2/2 passed. Полный integration suite: 183 passed, 2 unrelated failures — `character_portrait_endpoint_test.dart` и `object_storage_test.dart`, оба из-за отсутствующего `S3_ENDPOINT`. Diff check прошёл. Backend integration tests запускались только через repo script; вручную live schema не исправлялась.

Из `characters_mirror_flutter`:

```powershell
flutter analyze
flutter test
flutter test test/level_up_overview_test.dart test/level_up_feature_composition_test.dart test/feature_presentation_regression_test.dart test/feature_presentation_contract_test.dart
flutter test test/level_up_picker_test.dart test/level_up_spells_test.dart test/feature_presentation_contract_test.dart
flutter test test/selected_feature_choice_parity_test.dart
```

Analyze без issues. Полный suite: 644 passed, 1 skipped, 1 unrelated failure. Оставшийся тест `short hub starts directly under app bar and keeps multiclass in class card` ищет `AppBar`, хотя existing screen использует `PageSizeAppBar`. Production app bar этой работой не менялся; unrelated assertion не исправлялся. После последней resource-composition правки 27 relevant tests прошли.

Дополнительно picker/spells/contract: 23 passed; обновлённый offline selected-choice/property/resource/cache parity suite: 3 passed.

Formatter применён к затронутым handwritten Dart files. Проверки выполнялись через inline PowerShell, временные Python/PowerShell/Dart scripts и локальные Docker/Serverpod test sessions. Browser debug tools, Marionette и live UI sessions не использовались; screenshots не снимались. Самостоятельно запущенный development Postgres остановлен после read-only inspection; existing postgres_test container сохранён.

## 17. Отдельные задачи и ограничения

- Содержательный backfill shortDescriptions и проверка рабочего reference catalog.
- Восстановление повреждённых имён в existing test reference data.
- Existing `AnimatedSwitcher` resource counter issue: отдельное поведение не исправлялось; controls/callbacks покрыты regression tests.
- Optional grouping spell launcher/status rows: оставлено отдельной небольшой UI-задачей. Spell picker logic и limit semantics сохранены.
- Existing AppBar test и S3 test environment configuration.
- Live/manual UI flow с настоящим каталогом не выполнялся; UI проверен widget tests, server/offline данные — unit/integration tests.

Unarmored Defense, Level Down UI, source/ruleset filtering, auth/rate limits и choice persistence semantics не менялись. Коммиты и PR не создавались.

## Приложение: список файлов

- `characters_mirror_client/lib/src/protocol/data/general/character/character_feature_view_data.dart`
- `characters_mirror_client/lib/src/protocol/data/general/choice_option_data.dart`
- `characters_mirror_client/lib/src/protocol/data/general/class/class_data.dart`
- `characters_mirror_client/lib/src/protocol/data/general/class/subclass_data.dart`
- `characters_mirror_client/lib/src/protocol/protocol.dart`
- `characters_mirror_client/lib/src/protocol/views/class_step_feature_view.dart`
- `characters_mirror_client/lib/src/protocol/views/class_step_subclass_choice_view.dart`
- `characters_mirror_client/lib/src/protocol/views/selected_feature_choice_view.dart`
- `characters_mirror_flutter/lib/core/character/choice_group_presentation.dart`
- `characters_mirror_flutter/lib/core/character/feature_presentation.dart`
- `characters_mirror_flutter/lib/core/character/feature_text.dart`
- `characters_mirror_flutter/lib/core/character/subclass_presentation.dart`
- `characters_mirror_flutter/lib/core/offline/offline_character_resolver/feature_helpers.dart`
- `characters_mirror_flutter/lib/core/ui/widgets/choice_decision.dart`
- `characters_mirror_flutter/lib/core/ui/widgets/choice_picker.dart`
- `characters_mirror_flutter/lib/core/ui/widgets/feature_summary.dart`
- `characters_mirror_flutter/lib/core/ui/widgets/subclass_decision.dart`
- `characters_mirror_flutter/lib/features/character_creation/steps/background_step/widgets/background_features.dart`
- `characters_mirror_flutter/lib/features/character_creation/steps/class_step/class_features.dart`
- `characters_mirror_flutter/lib/features/character_creation/steps/class_step/widgets/class_feature_cards.dart`
- `characters_mirror_flutter/lib/features/character_creation/steps/class_step/widgets/class_progression_sections.dart`
- `characters_mirror_flutter/lib/features/character_creation/steps/class_step/widgets/related_feature_tables.dart` — удалён
- `characters_mirror_flutter/lib/features/character_creation/steps/summary_step/widgets/summary_overview.dart`
- `characters_mirror_flutter/lib/features/character_creation/widgets/creation_choice_group_card.dart`
- `characters_mirror_flutter/lib/features/character_sheet/presentation/pages/character/class_race_details_page.dart`
- `characters_mirror_flutter/lib/features/character_sheet/presentation/pages/character/class_race_formatters.dart`
- `characters_mirror_flutter/lib/features/character_sheet/presentation/widgets/character_feature_card.dart`
- `characters_mirror_flutter/lib/features/level_up/application/level_up_choices.dart`
- `characters_mirror_flutter/lib/features/level_up/application/level_up_overview.dart`
- `characters_mirror_flutter/lib/features/level_up/presentation/level_up_asi_decision.dart`
- `characters_mirror_flutter/lib/features/level_up/presentation/level_up_choice_section.dart`
- `characters_mirror_flutter/lib/features/level_up/presentation/level_up_feature_section.dart`
- `characters_mirror_flutter/lib/features/level_up/presentation/level_up_hub.dart`
- `characters_mirror_flutter/lib/features/level_up/presentation/level_up_picker.dart`
- `characters_mirror_flutter/test/character_feature_card_test.dart`
- `characters_mirror_flutter/test/character_sheet_navigation_test.dart`
- `characters_mirror_flutter/test/class_features_test.dart`
- `characters_mirror_flutter/test/creation_choice_selection_widgets_test.dart`
- `characters_mirror_flutter/test/feature_presentation_contract_test.dart`
- `characters_mirror_flutter/test/feature_presentation_regression_test.dart`
- `characters_mirror_flutter/test/level_up_choices_test.dart`
- `characters_mirror_flutter/test/level_up_feature_composition_test.dart`
- `characters_mirror_flutter/test/level_up_hub_test.dart`
- `characters_mirror_flutter/test/level_up_overview_test.dart`
- `characters_mirror_flutter/test/selected_feature_choice_parity_test.dart`
- `characters_mirror_server/lib/src/endpoints/models/general/character_data_endpoint/derived_source_resolution.dart`
- `characters_mirror_server/lib/src/endpoints/models/general/character_data_endpoint/normalization_basic_features.dart`
- `characters_mirror_server/lib/src/endpoints/models/general/character_data_endpoint/normalization_sorting_includes.dart`
- `characters_mirror_server/lib/src/endpoints/models/general/class_endpoints.dart`
- `characters_mirror_server/lib/src/endpoints/models/general/class_endpoints/class_write_helpers.dart`
- `characters_mirror_server/lib/src/feature_resource_summary.dart`
- `characters_mirror_server/lib/src/generated/data/general/character/character_feature_view_data.dart`
- `characters_mirror_server/lib/src/generated/data/general/choice_option_data.dart`
- `characters_mirror_server/lib/src/generated/data/general/class/class_data.dart`
- `characters_mirror_server/lib/src/generated/data/general/class/subclass_data.dart`
- `characters_mirror_server/lib/src/generated/protocol.dart`
- `characters_mirror_server/lib/src/generated/views/class_step_feature_view.dart`
- `characters_mirror_server/lib/src/generated/views/class_step_subclass_choice_view.dart`
- `characters_mirror_server/lib/src/generated/views/selected_feature_choice_view.dart`
- `characters_mirror_server/lib/src/models/data/general/character/character_feature_view_data.spy.yaml`
- `characters_mirror_server/lib/src/models/data/general/choice_option_data.spy.yaml`
- `characters_mirror_server/lib/src/models/data/general/class/class_data.spy.yaml`
- `characters_mirror_server/lib/src/models/data/general/class/subclass_data.spy.yaml`
- `characters_mirror_server/lib/src/models/views/class_step_feature_view.spy.yaml`
- `characters_mirror_server/lib/src/models/views/class_step_subclass_choice_view.spy.yaml`
- `characters_mirror_server/lib/src/models/views/selected_feature_choice_view.spy.yaml`
- `characters_mirror_server/migrations/20261006203500000-feature-presentation/definition.json`
- `characters_mirror_server/migrations/20261006203500000-feature-presentation/definition.sql`
- `characters_mirror_server/migrations/20261006203500000-feature-presentation/definition_project.json`
- `characters_mirror_server/migrations/20261006203500000-feature-presentation/migration.json`
- `characters_mirror_server/migrations/20261006203500000-feature-presentation/migration.sql`
- `characters_mirror_server/migrations/migration_registry.txt`
- `characters_mirror_server/test/integration/feature_presentation_test.dart`
- `characters_mirror_shared/lib/characters_mirror_shared.dart`
- `characters_mirror_shared/lib/src/feature_resource_summary.dart`
- `characters_mirror_shared/lib/src/subclass_display_name.dart`
- `docs/feature-presentation-data-audit.sql`
- `docs/feature-presentation-refactor-report.md`
- `test_fixtures/selected_feature_choice_contract.dart`

Логи full suites и временные scripts: `C:\Users\Matvey\.codex\.tmp\feature-presentation-refactor-20261006`.
