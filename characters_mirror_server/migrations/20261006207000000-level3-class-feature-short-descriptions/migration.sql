BEGIN;

-- UI-facing short descriptions for level-3 class features.
-- Legacy description remains untouched.

WITH texts("referenceKey","shortDescription") AS (
 VALUES
 ('bard_bard_college','Выберите коллегию бардов, которая определит особенности вашей дальнейшей специализации.'),
 ('bard_expertise','Выберите 2 навыка, которыми владеете: бонус мастерства в их проверках удваивается.'),
 ('fighter_martial_archetype','Выберите воинский архетип, который определит вашу дальнейшую боевую специализацию.'),
 ('monk_monastic_tradition','Выберите монастырскую традицию, которая определит дальнейшее развитие ваших техник.'),
 ('monk_deflect_missiles','Когда по вам попадает дальнобойная атака оружием, реакцией уменьшите урон на 1к10 + модификатор Ловкости + уровень монаха. Если урон снижен до 0 и у вас свободна рука, вы можете поймать снаряд и за 1 ци тут же совершить им дальнобойную атаку.'),
 ('paladin_divine_health','Вы получаете иммунитет к болезням.'),
 ('paladin_sacred_oath','Выберите священную клятву; она даёт умения клятвы, Канал божественности и заклинания клятвы.'),
 ('ranger_ranger_archetype','Выберите архетип следопыта, который определит вашу дальнейшую специализацию.'),
 ('ranger_primeval_awareness','Потратьте ячейку заклинания, чтобы на 1 минуту за её уровень ощущать присутствие определённых существ в пределах 1 мили, или 6 миль на избранной местности.'),
 ('rogue_roguish_archetype','Выберите архетип плута, который определит направление развития ваших особых навыков.')
)
UPDATE "class_feature_data" f
SET "shortDescription"=t."shortDescription",
    version=COALESCE(f.version,0)+1,
    "updatedAt"=now()
FROM texts t
WHERE f."referenceKey"=t."referenceKey"
  AND f."shortDescription" IS DISTINCT FROM t."shortDescription";

INSERT INTO "serverpod_migrations" ("module","version","timestamp")
VALUES ('characters_mirror','20261006207000000-level3-class-feature-short-descriptions',now())
ON CONFLICT ("module") DO UPDATE SET
 "version"='20261006207000000-level3-class-feature-short-descriptions',
 "timestamp"=now();

COMMIT;
