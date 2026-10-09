import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_server/src/spells/spell_cast_service.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  test('server typed cast rejects contradictory activation before spending',
      () {
    final c = CharacterData(
        derived: CharacterDerivedData(resolvedSpells: [
      ResolvedCharacterSpellData(
          spellKey: 'spell',
          spell: SpellData(level: 1),
          sources: [
            SpellSourceContextData(
                sourceKey: 'grant',
                label: 'Grant',
                known: true,
                prepared: true,
                alwaysPrepared: false,
                granted: true,
                canUseSlots: false,
                activation: SpellActivationData(
                    canUseStandardSlots: false,
                    canUsePactSlots: false,
                    slotless: true,
                    atWill: true,
                    resourceKey: 'ki',
                    resourceCost: 2))
          ])
    ]));
    expect(
        () => applyCharacterSpellCast(
            c,
            CharacterSemanticActionData(
                spellKey: 'spell',
                spellSourceKey: 'grant',
                level: 1,
                slotSource: 'none',
                spellPayment: 'atWill')),
        throwsA(isA<SpellCastFailure>()
            .having((e) => e.code, 'code', 'invalid_activation')));
    expect(c.resourceStates, isNull);
    expect(c.spellActivationUses, isNull);
  });
  withServerpod('Spell activation validation', (sessions, endpoints) {
    for (final race in [false, true]) {
      for (final update in [false, true]) {
        test(
            '${race ? 'race' : 'class'} ${update ? 'upsert' : 'add'} rejects invalid activation before write',
            () async {
          final db = sessions.build();
          try {
            final spell = await SpellData.db.insertRow(
                db, SpellData(referenceKey: 'validation_spell', level: 1));
            final valid = SpellActivationData(
                canUseStandardSlots: false,
                canUsePactSlots: false,
                slotless: true,
                atWill: true);
            final invalid = valid.copyWith(resourceKey: 'ki', resourceCost: 2);
            final failure = throwsA(isA<SpellCastFailure>()
                .having((e) => e.code, 'code', 'invalid_activation'));
            if (race) {
              final parent =
                  await RaceData.db.insertRow(db, RaceData(name: 'Fixture'));
              final feature = await RaceFeatureData.db.insertRow(
                  db, RaceFeatureData(raceId: parent.id, name: 'Fixture'));
              var grant = RaceFeatureSpellGrantData(
                  featureId: feature.id!,
                  spellId: spell.id!,
                  activation: valid);
              if (update) {
                grant = await endpoints.raceFeatureSpellGrantData
                    .add(sessions, grant);
              }
              await expectLater(
                  update
                      ? endpoints.raceFeatureSpellGrantData
                          .upsert(sessions, grant.copyWith(activation: invalid))
                      : endpoints.raceFeatureSpellGrantData
                          .add(sessions, grant.copyWith(activation: invalid)),
                  failure);
              final rows = await RaceFeatureSpellGrantData.db
                  .find(db, where: (t) => t.featureId.equals(feature.id!));
              expect(rows, hasLength(update ? 1 : 0));
              if (update) {
                expect(rows.single.activation!.resourceCost, isNull);
              }
            } else {
              final parent = await ClassData.db
                  .insertRow(db, ClassData(referenceKey: 'validation_class'));
              var grant = ClassSpellGrantData(
                  sourceClassId: parent.id,
                  spellId: spell.id!,
                  activation: valid);
              if (update) {
                grant =
                    await endpoints.classSpellGrantData.add(sessions, grant);
              }
              await expectLater(
                  update
                      ? endpoints.classSpellGrantData
                          .upsert(sessions, grant.copyWith(activation: invalid))
                      : endpoints.classSpellGrantData
                          .add(sessions, grant.copyWith(activation: invalid)),
                  failure);
              final rows = await ClassSpellGrantData.db
                  .find(db, where: (t) => t.sourceClassId.equals(parent.id!));
              expect(rows, hasLength(update ? 1 : 0));
              if (update) {
                expect(rows.single.activation!.resourceCost, isNull);
              }
            }
          } finally {
            await db.close();
          }
        });
      }
    }
  });
}
