# Choice requirements (Stage 2)

`ChoiceOptionData.requirements` is an optional list of typed requirements. All
requirements on an option must pass. Older option records without this field
remain valid. The server re-evaluates selected options while saving a character.

An admin can upsert options with `AdminEndpoint.importChoiceOptions`. The JSON
argument uses stable group and option keys; an existing group must already be
present. Omit `requirements` to preserve the current requirements on an
existing option, or provide an empty list to clear them.

```json
{
  "options": [
    {
      "groupKey": "warlock_invocations",
      "optionKey": "deepened_pact",
      "name": "Deepened Pact",
      "requirements": [
        { "type": "minimumClassLevel", "classKey": "warlock", "value": 5 },
        { "type": "knownSpell", "referenceKey": "hex" }
      ]
    }
  ]
}
```

The supported types are `minimumClassLevel` (`classKey`, `value`),
`minimumCharacterLevel` (`value`), `abilityScore` (`ability`, `value`),
`knownSpell` and `knownCantrip` (`referenceKey`), `feature` (`referenceKey`),
and `selectedChoiceOption` (`choiceGroupKey`, `optionKey`). Class and feature
keys are catalog `referenceKey` values, not localized names or database IDs.
The new catalog keys are nullable so existing catalog data needs no backfill.

Spell selection semantics match Stage 1: `knownSpell` includes `knownSpell`
and Wizard `spellbookSpell` selections, excludes `preparedSpell`, and
`knownCantrip` matches only `knownCantrip`. The shared pure evaluator is used by
the server validator and the Flutter offline adapter. Flutter can decorate a
`ChoiceGroupView` with evaluated status; the choice card disables unavailable
options and shows their failed requirement reasons. Group duplicate and
exclusive policies remain separate and are also enforced by the server.
