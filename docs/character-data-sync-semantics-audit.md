# Архитектурный аудит mutable state `CharacterData`

Дата аудита: 2026-09-14.

## Область и вывод

Аудит охватывает persisted-поля `CharacterData`, вложенные character-модели, UI/application writers, клиентский operation builder и серверное применение операций. `CharacterDerivedData`, `version`, `syncTargetRevisions`, `createdAt` и `updatedAt` не считаются пользовательским mutable state: `derived` пересобирается сервером, остальные поля являются служебными метаданными.

Текущая схема уже подходит для независимых scalar fields, map entries и разных элементов коллекций. До multi-device реализации есть четыре архитектурных блокера:

1. Operation sync используется только на Android. Web и desktop вызывают `saveCharacter` с полным snapshot без явного conflict result: stale snapshot обычно получает текущую серверную версию обратно, а его независимое локальное изменение теряется вместо merge.
2. `preparedSpellKeys`, `activeConditions`, `manualSkillProficiencies` и `manualSavingThrowProficiencies` являются coarse scalar targets.
3. Счётчики сохраняются абсолютными значениями, хотя UI часто уже знает действие: damage/heal, spend/restore, cast, rest. Diff snapshot не может надёжно восстановить этот intent.
4. Identity некоторых вложенных сущностей не совпадает с доменной identity. Особенно опасны `featureOverrides` и nested starting equipment.

Дополнительный дефект target bookkeeping: operation path заранее повышает revision только запрошенного target, затем pruning/normalization может изменить другие persisted targets. Эти побочные изменения не получают новую target revision.

## Фактические write paths

- Создание персонажа: `character_creation_state.dart` собирает один `CharacterData`; `summary.dart` передаёт его в `CharacterRepository.saveCharacter`.
- Лист персонажа: `CharacterSheetController` принимает snapshots от extensions `ability_operations`, `combat_operations`, `personal_operations`, `spell_operations`, `feature_resource_operations`.
- Android: repository -> SQLite `saveLocal` -> `buildCharacterSyncOperations(previous, next)` -> queue -> `syncCharacters`.
- Web/Windows: repository -> `client.characterData.saveCharacter(normalized)`, минуя operation queue.
- Серверные API writers: `saveCharacter`, `syncSaveCharacter`, legacy `syncCharacters.changes`, v2 `syncCharacters.operations`, `syncDeleteCharacter`, `delete`.
- Сервер при первом create дополнительно материализует equipment и weapon attacks из starting equipment; при каждом save prune-ит feature overrides и resource states.

## Классификация

- **A, absolute scalar set**: новое значение заменяет старое; stale write того же target конфликтует.
- **B, map entry**: независимый target на ключ карты; разные ключи сливаются.
- **C, set membership**: независимые idempotent add/remove на member key; порядок незначим.
- **D, identified collection item**: create/delete по identity, update либо атомарным item payload, либо по subfield.
- **E, semantic counter/resource**: action применяется сервером к актуальному значению; absolute set остаётся ручным fallback.
- **F, destructive**: удаление персонажа или item; stale delete не должен уничтожать более новое изменение.

Оценка concurrency ниже является продуктовой оценкой по существующим UI workflows, а не статистикой production usage.

## Полный инвентарь persisted state

| Model path и Dart type | Где изменяется сейчас | Identity / порядок | Вероятность concurrency |
|---|---|---|---|
| `name: String?` | creation setters; `savePersonalInfo` | field; порядок n/a | средняя |
| `age/height/weight/eyes/skin/hair: String?` | creation setters; `savePersonalInfo` | отдельный field; порядок n/a | низкая |
| `appearance/backstory/goals/alliesOrganizations/personalityTraits/ideals/bonds/flaws: String?` | creation setters; `savePersonalInfo` | отдельный field; порядок n/a | средняя |
| `experience: int?` | только creation `setExperience`; sheet writer отсутствует | field; порядок n/a | средняя после появления XP actions |
| `alignmentValue: CharacterAlignment?` | creation; `savePersonalInfo` | field | низкая |
| `race/subrace/background: *Data?` | creation drafts; persisted фактически relation id | field по relation id; зависимы от choices/selections/equipment | низкая, но большой blast radius |
| `baseAbilityScores: Map<String,int>?` | creation attributes; ability editor | key = `Ability.name`; порядок незначим | средняя |
| `customAbilityBonuses: Map<String,int>?` | ability editor | key = `Ability.name`; порядок незначим | низкая |
| `useFlexibleAbilityBonuses: bool?` | creation attributes | field | низкая |
| `currentHp/temporaryHp: int?` | creation setters; HP calculator; long rest | field; текущие sparse defaults: null = max/zero | высокая |
| `deathSaveSuccesses/deathSaveFailures: int?` | HP death-save checkboxes; HP heal/reset; long rest | два field; диапазон 0..3 | высокая во время боя |
| `hpPerLevelBonus/hpFlatBonus: int?` | HP settings | отдельные field | низкая |
| `currentHitDice: Map<String,int>?` | HP settings; long rest | key = die kind (`d6`, `d8`); null entry = max | средняя |
| `hitDiceMaxOverrides: Map<String,int>?` | HP settings | key = die kind; null entry = derived max | низкая |
| `currentSpellSlots: Map<int,int>?` | slot flags, cast, long rest | key = spell level; null entry = derived max | высокая |
| `activeConcentrationSpellName: String?` | cast; cancel concentration | field | высокая; связана с cast |
| `customInitiativeBonus/customArmorClassBonus: int?` | combat settings | отдельные field | низкая |
| `walkingSpeed/swimmingSpeed/climbingSpeed/flyingSpeed: int?` | movement settings/init | отдельные field | низкая |
| `displayedSpeedKind: CharacterSpeedKind?` | movement settings/init | field, это presentation preference | низкая |
| `customSpellSaveDcBonus/customSpellAttackBonus: int?` | spell settings | отдельные field | низкая |
| `preparedSpellKeys: List<String>?` | prepare/unprepare; forget spell | доменная identity = normalized spell key; порядок незначим; null = defaults | высокая |
| `activeConditions: List<ConditionType>?` | conditions dialog; remove status | identity = condition enum; порядок незначим | высокая |
| `exhaustionLevel: int?` | conditions dialog/remove | field 0..6 | средняя |
| `inspiration: bool?` | status toggle; creation setter | field; null = false | средняя |
| `manualSkillProficiencies: List<CharacterSkillProficiencyState>?` | ability/skill editor | доменная identity = `skill`; value = level; null = весь derived default | средняя |
| `manualSavingThrowProficiencies: List<Ability>?` | ability editor | identity = ability; set, но null = весь class default | средняя |
| `notes[*].id/text` | notes page; creation single-note bridge | UUID identity после normalization; list order показывается | средняя |
| `equipment[*].id/name/quantity/type` | inventory text field; initial server materialization | UUID item identity; list order показывается | средняя; quantity потенциально высокая |
| `attacks[*].id/name/leadingAbility/damage/customAttackBonus/damageType/description` | attack autosave dialog; initial weapon materialization | UUID item identity; list order показывается | средняя |
| `attacks[*].damageParts[*]: DamagePartData` | attack dialog add/remove/edit | только позиционный index, стабильного id нет; порядок влияет на отображение/legacy first part | средняя внутри одного attack |
| `attacks[*].tags: List<String>?` | attack dialog | фактически set-like, но порядок сохраняется | низкая |
| `featureOverrides[*].sourceType/sourceId/name/description/tags` | feature editor/reset | доменная identity = `(sourceType,sourceId)`; порядок server-canonical | средняя |
| `resourceStates[*].current` | feature +/- controls; short/long rest | identity = `(sourceType,sourceId,resourceKey)`; sparse, null item = derived max | высокая |
| `classEntries[*].classData/subclass/level/isStartingClass` | creation primary class | UUID identity; `classOrder` задаёт порядок | низкая сейчас |
| `classEntries[*].classOrder/notes/hpMode/hpRolledValues[*]` | creation; HP settings меняет HP fields | item identity; `hpRolledValues` позиционно соответствует уровню | средняя для HP настройки |
| `choices[*].*` | race/class/background draft builders | текущая UUID identity; доменная identity ближе к source + group + slot | низкая сейчас, опасна при будущем editor |
| `skillSelections[*].*` | class/background selection UI | текущая UUID identity; доменная identity = source group + slot | низкая сейчас |
| `spellSelections[*].*` | creation selection; sheet learn/forget | UUID сейчас; learned spells семантически key membership, constrained choices являются slots | средняя |
| `startingEquipmentSelections[*].*` | class/background creation UI | UUID сейчас; доменная identity = source + sourceEntry + selection slot | низкая после create |
| `startingEquipmentSelections[*].resolutions[*].*` | class/background equipment dialogs | UUID сейчас; доменная identity = parent selection + sourceLineEntryId | низкая после create |
| Character delete | character list | character server id | низкая, последствие максимальное |

Не найдены отдельные persisted manual-поля для languages, tools, armor training и weapon training. Они получаются через `choices`, `skillSelections` и reference features в `derived`. `maxHp`, max spell slots и max feature resources также не persisted: сохраняются только их inputs или sparse current overrides.

## Итоговая матрица решений

| Model path | Current target | Current operation | Recommended semantics | Conflict policy | Requires UI/action intent? | Migration needed? |
|---|---|---|---|---|---|---|
| `name`, personal short fields | `field:<name>` | `setField` | A | stale same field reject | нет | нет |
| biography fields | `field:<name>` | `setField` | A, каждый текст отдельно | stale same field reject | нет | нет |
| `experience` | `field:experience` | `setField` | E `adjustExperience(delta)` + A fallback | deltas serializable/idempotent; absolute stale reject | да для award/remove | protocol only |
| `alignmentValue` | `field:alignmentValue` | `setField` | A | stale reject | нет | нет |
| `race/subrace/background` | отдельные field targets | `setField` | A; editor-level compound selection command при каскадной очистке | stale changed relation reject; все реально изменённые dependent targets получают revisions | да для compound replace | protocol для atomic command |
| `baseAbilityScores[ability]` | `map:baseAbilityScores:<ability>` | set/remove map entry | B | same ability conflict; разные merge | нет | нет |
| `customAbilityBonuses[ability]` | `map:customAbilityBonuses:<ability>` | set/remove map entry | B | same ability conflict | нет | нет |
| `useFlexibleAbilityBonuses` | field | `setField` | A | stale reject | нет | нет |
| `currentHp` + `temporaryHp` | два field targets | два `setField` | E: `applyDamage`, `heal`, `grant/adjustTemporaryHp`; A fallback для ручной коррекции | actions применяются атомарно к актуальным HP; invalid action reject | да | protocol action payload |
| death saves | два field targets | `setField` | A для checkbox correction; optional E `recordDeathSave/reset` | same counter absolute conflict; semantic event server-ordered | только для roll/event | protocol optional |
| HP max inputs (`hp*Bonus`, class HP fields) | fields + whole class item | `setField` + item upsert | A/B/D; одна settings-команда, если нужна атомарность | subfield conflict; settings save all-or-reject | только для atomic form commit | item subfield protocol |
| `currentHitDice[die]` | map entry | set/remove map entry | E `adjustHitDice(die,delta)` + B fallback | delta validates 0..effectiveMax; fallback stale reject | да для spend/restore | protocol only |
| `hitDiceMaxOverrides[die]` | map entry | set/remove map entry | B | same die conflict | нет | нет |
| `currentSpellSlots[level]` | map entry | set/remove map entry | E `adjustSpellSlots(level,delta)` + B fallback | each cast decrement applies if available; otherwise reject | да для cast/spend/restore | protocol only |
| `activeConcentrationSpellName` | field | `setField` | A manually; часть atomic `castSpell` command при cast | manual same field conflict; cast updates slot+concentration together | да для cast | protocol command |
| initiative/AC/speeds/displayed speed | отдельные fields | `setField` | A | stale same field reject | нет | нет |
| spell save/attack bonuses | отдельные fields | `setField` | A | stale same field reject | нет | нет |
| `preparedSpellKeys[spellKey]` | coarse `field:preparedSpellKeys` | whole-list `setField` | C add/remove member over effective set | different keys merge; opposite stale action same key conflicts | нет, set diff достаточен | fine target fallback from coarse revision |
| `activeConditions[condition]` | coarse `field:activeConditions` | whole-list `setField` | C add/remove member | different conditions merge; same condition idempotent/opposite stale conflict | нет | fine target fallback from coarse revision |
| `exhaustionLevel` | field | `setField` | A now; E increment/decrement only for explicit future actions | stale absolute reject | да только для delta UI | нет / protocol optional |
| `inspiration` | field | `setField` | A | concurrent grant/spend is a real conflict unless product defines ordering | нет | нет |
| `manualSkillProficiencies[skill]` | coarse whole list field | `setField` | B keyed by skill, preferably sparse override over derived value | different skills merge; same skill conflict | нет | new override representation + data migration |
| `manualSavingThrowProficiencies[ability]` | coarse whole list field | `setField` | C-like tri-state override (`inherit/add/remove`) | different abilities merge; same ability conflict | нет | new override representation + data migration |
| `notes[id].text` | `item:notes:<id>` | whole item upsert/remove | D, atomic note item | same note edit/delete conflict; different ids merge | нет | add `orderKey` only for reorder |
| `equipment[id].name/type` | `item:equipment:<id>` | whole item upsert/remove | D subfields | same subfield conflict; delete vs edit conflict | нет | structured editor + optional subfield protocol |
| `equipment[id].quantity` | whole equipment item | item upsert | E delta + A item-field fallback | deltas merge if item exists; delete wins/rejects stale delta by policy | да for +/- | protocol; `orderKey` optional |
| `attacks[id]` scalar subfields | whole attack item | item upsert/remove | D with per-subfield targets; whole-item fallback for coherent dialog commit | same subfield conflict; independent subfields merge | нет | subfield protocol |
| `attacks[id].damageParts[index]` | whole attack item | item upsert | D only after stable part id; otherwise atomic whole attack | current concurrent part edits conflict intentionally | нет | nested ids/orderKey if split |
| `attacks[id].tags[tag]` | whole attack item | item upsert | C if split; retaining atomic attack is acceptable first stage | per-tag merge only after split | нет | protocol optional |
| `featureOverrides[source].name/description` | intended item target, practically unstable id/natural key mix | item upsert/remove | D, natural source identity, per-field targets | independent name/description merge; reset conflicts with any stale subfield | нет | target-key migration, no table schema |
| `featureOverrides[source].tags[tag]` | same whole item | item upsert | C under natural source identity | different tags merge | нет | protocol/fine targets |
| `resourceStates[source,key].current` | `resource:<sourceType>:<sourceId>:<key>` | item upsert/remove | E delta/spend/restore + A fallback | apply if resource exists and bounds permit; no silent clamp for spend | да | protocol only |
| `classEntries[id].class/subclass/level/...` | whole class item | item upsert/remove | D per subfield; fields with coupled invariants may remain atomic group | same subfield conflict; delete vs edit conflict | нет | subfield protocol |
| `classEntries[id].classOrder` | whole class item | item upsert | D rank/orderKey | independent insert/reorder should not renumber all items | да для reorder command | relation schema/backfill if new column |
| `classEntries[id].hpRolledValues[level]` | whole class item | item upsert | B-like nested entry by level index | different levels merge; same level conflict | нет | nested target protocol |
| `choices[*]` | `item:choices:<uuid>` | item upsert/remove | D by stable semantic choice slot; selected option/value atomic | different slots merge; alternatives in same slot conflict | нет | identity/backfill; possible dedupe |
| `skillSelections[*]` | item UUID | item upsert/remove | D by stable source-group slot | same slot differing skill conflict | нет | identity/backfill; possible dedupe |
| learned `spellSelections[*]` | item UUID | item upsert/remove | C membership by class/source + kind + spell key | independent spells merge; duplicate add idempotent | нет | natural key/backfill/dedupe |
| constrained `spellSelections[*]` | item UUID | item upsert/remove | D by stable selection slot | same slot alternatives conflict | нет | identity/backfill |
| `startingEquipmentSelections[*]` | parent item UUID | item upsert/remove | D by source block + slot; parent payload must exclude resolutions | same slot alternative conflict; different blocks merge | нет | identity/backfill; builder change |
| nested equipment resolution | nested item `(selectionId,resolutionId)` plus parent upsert | duplicate parent + nested upsert/remove | D by parent semantic key + `sourceLineEntryId`; payload atomic | different lines merge; same line alternative conflict | нет | target migration/dedupe |
| character delete | `character:<id>` | `deleteCharacter` | F | reject stale delete after any newer character change | да, explicit destructive action | нет |
| collection item delete | item target | `removeListItem` | F at item identity | stale edit/delete conflict; never recreate deleted parent implicitly | да | tombstone retention already partly present |

## Правильно спроектированные targets

- Все независимые top-level scalar fields имеют собственный `field:*` target.
- `baseAbilityScores`, `customAbilityBonuses`, `currentHitDice`, `hitDiceMaxOverrides`, `currentSpellSlots` уже разделены по map key.
- Notes, equipment, attacks, class entries, choices, skill/spell selections разделены по item id; разные IDs не конфликтуют.
- Resource identity `(sourceType, sourceId, resourceKey)` соответствует домену.
- Delete использует character revision и защищён от stale resurrection; applied `changeId` обеспечивает idempotency.
- Tombstone target revisions для удалённых map/list items позволяют отклонить stale recreate того же target.

## Coarse targets, которые нужно разделить

1. `activeConditions` -> target на `ConditionType`.
2. `preparedSpellKeys` -> target на normalized spell key.
3. `manualSkillProficiencies` -> target на `Skill`, value = proficiency level.
4. `manualSavingThrowProficiencies` -> target на `Ability` с явным inherit/add/remove.
5. Feature override -> natural source identity, затем `name`, `description`, `tags:<tag>`.
6. Multi-field items можно делить по subfield по мере реальной конкуренции; наиболее полезны class HP fields и attack editor autosave.
7. Starting equipment parent и nested resolutions должны быть непересекающимися targets.

## Identity defects

### Feature override

Серверная `_normalizedFeatureOverrides` пересоздаёт объект без `id`, а `CharacterRecord` сохраняет именно этот результат. Клиентская normalization, напротив, генерирует UUID. Builder выбирает UUID, если он есть, и natural `(sourceType,sourceId)` только как fallback. Поэтому previous и next могут получить разные identities и одно редактирование превратится в remove + insert с несогласованными revision keys.

Рекомендация: для sync всегда использовать `(sourceType,sourceId)`, не `id`. Поле `id` можно оставить для wire compatibility, но оно не должно участвовать в target identity.

### Notes и inventory bridges

`notesFromTexts` сохраняет identity по текущему index. Удаление первой заметки сдвигает вторую на первый id, то есть выражается как изменение текста одного item плюс удаление другого, а не удаление нужного item. `inventoryItemsFromText` сворачивает весь inventory в один item и сохраняет только id первого элемента. Item-level протокол здесь формально есть, но UI writer уничтожает его смысл.

Рекомендация: writers должны принимать item id и изменять конкретный item. Для inventory нужен structured editor до заявления о безопасной multi-device синхронизации equipment.

### Choices и selections

Случайные UUID отличают физические строки, но не логические slots. Два устройства могут независимо создать разные UUID для одного choice slot, после чего сервер сохранит оба. Валидация сейчас проверяет форму и размеры, но не уникальность доменных keys/cardinality.

Рекомендация: определить стабильный `slotKey` для constrained choices/selections и natural membership key для learned spells. Добавить server uniqueness/invariant validation.

### Starting equipment

Нормализаторы creation flow часто пересоздают selections/resolutions без id. После persistence UUID появляются, но future edit через тот же flow способен сменить identity. Resolution логически идентифицируется `sourceLineEntryId` внутри selection, а не случайным UUID.

## Поля, требующие semantic operations

- HP: `applyDamage(amount)`, `heal(amount)`, отдельная согласованная политика temporary HP.
- XP: `adjustExperience(delta)` для awards/removals.
- Spell slots: `adjustSpellSlots(level, delta)`; `castSpell` должен атомарно потратить слот и при необходимости сменить concentration.
- Hit dice: `adjustHitDice(kind, delta)` для spend/recovery.
- Feature resources: `adjustResource(source,key,delta)`, плюс restore action.
- Equipment quantity: delta только для явных +/- actions.
- Rest: explicit `applyRest(restType)` предпочтительнее пачки независимых absolute writes, потому что он затрагивает HP, temp HP, saves, slots, hit dice и feature resources.

Semantic operation принимается независимо от stale target revision только если `changeId` новый, entity/target существует и domain preconditions выполняются. Например, второй concurrent spend при остатке 1 должен быть rejected как insufficient resource, а не clamp-нут в 0 и не считаться успешным.

## Что нельзя безопасно вывести из snapshot diff

- `currentHp: 20 -> 15` не говорит, был ли это damage 5, manual correction или результат damage 8 после temporary HP.
- `temporaryHp: 3 -> 5` не отличает grant/stack/replace и связанную часть damage action.
- Slot/resource/hit-die `3 -> 2` не отличает spend от ручной установки.
- XP `100 -> 150` не отличает award 50 от коррекции total.
- Несколько локальных действий, coalesced в один snapshot, теряют последовательность и domain preconditions.
- Rest и cast являются составными действиями; набор независимых diffs не гарантирует атомарность.

Следовательно, diff builder оставляется для A/B/C/D и absolute fallback. E-операции создаются в action/controller layer в момент пользовательского действия.

## Ordering audit

Текущий builder индексирует top-level collections по id и намеренно не создаёт operation для чистой перестановки. Это подтверждено unit-тестом. Persisted и видимый порядок есть у `notes`, `equipment`, `attacks`; сейчас он не синхронизируется.

- `classEntries.classOrder` уже persisted, но целые последовательные integers требуют изменения нескольких items при reorder.
- `choices`, `skillSelections`, `spellSelections`, `startingEquipmentSelections` используют `selectionIndex`. Во многих местах это semantic slot, а не presentation order; смешивать эти понятия нельзя.
- `attack.damageParts` позиционны, стабильной identity нет, порядок важен.
- Conditions, prepared spells, manual proficiencies, feature tags и resource states должны canonical-sort-иться и не иметь пользовательского порядка.

Рекомендация без реализации: добавить nullable `orderKey` только туда, где пользователь реально управляет порядком: notes/equipment/attacks и, при необходимости, damage parts. Для class entries либо добавить `orderKey`, либо перейти на разреженные ranks с редким rebalance. Старые записи получают deterministic keys по текущему order. `selectionIndex` оставить slot semantics.

## Примеры конфликтов

### Истинный конфликт

- Два устройства задают разные `name`.
- Два устройства меняют `baseAbilityScores.strength` на разные values.
- Одно редактирует note, второе удаляет тот же note id.
- Два устройства выбирают разные alternatives для одного choice slot.
- Два устройства вручную задают разные absolute resource values.

### Ложный конфликт из-за coarse target

- Одно добавляет `poisoned`, второе добавляет `prone`.
- Одно prepares `fireball`, второе prepares `haste`.
- Одно меняет proficiency `arcana`, второе `stealth`.
- Одно меняет feature override name, второе tags.
- Два устройства разрешают разные starting-equipment lines, но parent upsert содержит весь `resolutions` list.

### Конфликт исчезает с semantic operation

- Два damage actions должны оба примениться к актуальным HP в server order.
- Два casts должны потратить два slots, если их достаточно.
- Две XP awards должны суммироваться.
- Два spends feature resource должны оба примениться, если хватает charges.
- Два quantity increments одного equipment item должны суммироваться.

## Изменения protocol model

Минимальный следующий этап:

1. Добавить member operations (`addSetMember`, `removeSetMember`) и member target type/key.
2. Добавить typed counter/action operations. Не использовать универсальный непроверяемый JSON command.
3. Добавить item-subfield addressing (`collection`, `itemId`, `subfieldPath`) либо отдельный `setListItemField`.
4. Добавить typed compound commands для `applyDamage/heal`, `castSpell`, `applyRest`, если нужна атомарность нескольких persisted targets.
5. После server normalization вычислять фактически изменённые targets и повышать revisions каждого, а не только requested target.
6. Все операции сохраняют текущую idempotency по `changeId`.
7. Добавить `syncProtocolVersion`/capabilities, чтобы новый клиент не отправлял неизвестные operation enum values старому серверу.

CRDT, event sourcing и OT для этого не нужны. Достаточно server-serialized typed operations, per-target revisions и cursor pull.

## Изменения controller/action layer

- Repository должен иметь единый operation path на Android, web и desktop. Durable storage может отличаться, semantics не должна.
- HP calculator должен передавать `HitPointAction + amount`, а не только итоговые totals; ручная настройка остаётся absolute save.
- Resource +/- controls должны передавать delta; прямой numeric editor, если появится, остаётся absolute.
- `castSpell` должен создавать одну typed action, а direct slot flags остаются absolute map-entry set.
- `restoreResources` должен создавать rest command, а не snapshot из многих counters.
- Conditions/prepared/proficiency writers могут безопасно строить member operations из set/map diff.
- Notes/equipment writers должны работать по stable item id, не по index или whole-text bridge.
- Creation может оставаться create snapshot: до первого server id concurrent editing одного персонажа на двух устройствах не существует.

## Миграции и backward compatibility

- Сервер продолжает принимать старые `setField`, map и item operations. Старые coarse writes конфликтуют по coarse target и не должны незаметно смешиваться с fine writes.
- Для fine member keys baseline берётся из существующего coarse revision, если fine key ещё отсутствует. Coarse tombstone хранится до завершения поддержки старых клиентов.
- Feature override revision keys лениво переводятся с UUID aliases на natural source key; persisted list не требует новой таблицы.
- Manual proficiency representation требует additive новых override fields. Backfill должен вычислить overrides так, чтобы effective proficiencies не изменились; простое копирование current full list семантически неверно.
- `orderKey` внутри JSON item требует protocol generation и lazy/backfill данных; новый relation column для class/selection ordering потребует Serverpod migration.
- Semantic slot keys для relation records требуют nullable additive columns, backfill, dedupe существующих logical duplicates и затем unique indexes.
- Новые enum/model fields сначала nullable/additive; после rollout старых клиентов ограничения можно ужесточить.

## Тесты следующего этапа

1. Каждая A/B target policy: same-target reject, independent target merge.
2. Conditions/prepared/manual proficiencies: разные members merge; same member add/remove idempotency и stale opposite conflict.
3. Counter concurrency: two decrements, increment+decrement, insufficient resource, retry same `changeId`, absolute-set conflict.
4. HP: damage through temp HP, concurrent damage, heal+damage server ordering, manual absolute fallback.
5. Compound actions: cast slot+concentration и long rest all-or-nothing, включая injected failure.
6. Identity: feature override id churn regression; duplicate learned spell; same choice slot from two UUIDs; starting resolution by line id.
7. Parent/nested isolation: two different starting equipment resolutions converge без parent overwrite.
8. Writers: deleting first note preserves second note id; inventory edit does not discard sibling items.
9. Ordering: pure reorder persists through sync/reload; concurrent insert/reorder; deterministic legacy rank backfill.
10. Cross-platform: Android + Chrome/Windows both emit equivalent operations; ни один mutable update не вызывает unsafe full snapshot save.
11. Normalization side effects: every pruned/normalized target gets a new revision/tombstone.
12. Backward compatibility: old coarse client vs new fine client in both operation orders.

## Рекомендуемый порядок реализации

1. Перевести web/desktop на тот же operation contract и закрыть feature-override identity defect.
2. Разделить C targets и исправить starting-equipment parent/nested overlap.
3. Ввести E operations из controller layer: resources, slots, HP, rest/cast.
4. Уточнить identities constrained choices/selections и добавить server invariants.
5. Добавить ordering только для UI, где reorder реально поддерживается.
6. После каждого шага расширять двухустройственные integration tests; не смешивать все миграции в один rollout.
