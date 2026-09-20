# Semantic actions в Character Sync v4

## Назначение

Sync protocol v4 передаёт известный application layer пользовательский intent как typed operation, а не восстанавливает его из snapshot diff. Поддерживаются `applyDamage`, `heal`, `grantTemporaryHp`, `adjustSpellSlots`, `castSpell`, `adjustHitDice`, `adjustResource`, `adjustExperience` и `applyRest`.

Manual numeric edits, настройки и generic `saveCharacter` остаются absolute operations. Они меняют baseline и являются semantic barriers.

## Barrier token

`CharacterRecord.syncBarrierTokens` хранит server-only canonical token по logical target. Aggregate возвращает копию клиенту в `CharacterData.syncBarrierTokens`, но snapshot write не может задать эти значения: сервер сохраняет собственную карту.

При создании semantic operation клиент записывает в `baseBarrierTokens` token каждого затрагиваемого target:

- существующий `syncBarrierTokens[target]`;
- иначе `revision:<syncTargetRevisions[target]>`;
- иначе стабильный `revision:0` для ещё не материализованного sparse target.

Сервер под row lock сравнивает переданные tokens с canonical tokens. Несовпадение даёт terminal rejection `crossed_barrier`.

Обычная semantic action не меняет token. Поэтому несколько actions, созданных от одной baseline, последовательно применяются к актуальному canonical state. Absolute operation меняет token каждого реально изменённого counter target на свой `changeId`. `applyRest` меняет tokens всех затрагиваемых reset targets на свой `changeId`, поэтому offline action, созданная до rest, не проходит после него.

`revision:0` не зависит от общей версии персонажа: mutation независимого target не создаёт ложный barrier для отсутствующего sparse map/resource target. После первого absolute изменения target получает явный token; удалённые значения дополнительно сохраняют target revision как tombstone.

## Транзакция и idempotency

Каждая operation выполняется в существующей PostgreSQL transaction:

1. advisory lock по `(userId, changeId)`;
2. проверка `CharacterAppliedChangeRecord`;
3. row lock и загрузка canonical aggregate;
4. проверка barrier и domain preconditions;
5. применение typed action;
6. validation, normalization и pruning;
7. post-normalization diff и revisions всех реально изменённых targets;
8. запись character, relations, sync event и applied `changeId`;
9. commit.

Повторный `changeId` возвращает уже сохранённый canonical aggregate и не применяет delta второй раз. Ошибка в любом шаге откатывает всю operation, включая compound `castSpell` и `applyRest`.

## Client lifecycle

На Android controller сначала строит optimistic snapshot и передаёт typed action в `CharacterRepository.saveSemanticAction`. SQLite transaction одновременно сохраняет dirty snapshot и отдельную operation с action payload. Semantic operations не coalesce-ятся и переживают restart.

После acknowledgement cache заменяется canonical snapshot. После terminal semantic rejection operation удаляется из retry queue; если более новых pending operations нет, optimistic snapshot заменяется самым свежим canonical character из sync response.

Web и Windows в этом этапе сохраняют прежний snapshot fallback. Полный operation lifecycle, rebase нескольких локальных действий после rejection и authoritative full resync относятся к следующему этапу.

## Совместимость

- v3 member operations продолжают приниматься сервером.
- Semantic operations требуют protocol v4.
- Android сначала выполняет capability probe и не отправляет неизвестные v4 enum values серверу v3.
- Legacy absolute writes создают те же barrier tokens, поэтому v4 action не может пересечь более новую correction старого клиента.
