import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ClassDataEndpoint extends Endpoint {
  Future<List<ClassData>> getAll(Session session) async {
    return await ClassData.db.find(session);
  }

  Future<ClassData> add(Session session, ClassData classData) async {
    classData.createdAt ??= DateTime.now();
    classData.updatedAt ??= DateTime.now();
    classData.version ??= 1;
    return await ClassData.db.insertRow(session, classData);
  }

  Future<ClassData> upsert(Session session, ClassData classData) async {
    final existing = await ClassData.db.find(
      session,
      where: (t) => t.id.equals(classData.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      classData.id = old.id;
      classData.version = (old.version ?? 0) + 1;
      classData.createdAt = old.createdAt ?? now;
      classData.updatedAt = now;

      await ClassData.db.updateRow(session, classData);
      return classData;
    } else {
      classData.version = classData.version ?? 1;
      classData.createdAt = now;
      classData.updatedAt = now;

      return await ClassData.db.insertRow(session, classData);
    }
  }

  Future<void> delete(Session session, int id) async {
    await ClassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class ClassFeatureDataEndpoint extends Endpoint {
  Future<List<ClassFeatureData>> getAll(Session session) async {
    return await ClassFeatureData.db.find(session);
  }

  Future<ClassFeatureData> add(Session session, ClassFeatureData item) async {
    return await ClassFeatureData.db.insertRow(session, item);
  }

  Future<ClassFeatureData> upsert(
      Session session, ClassFeatureData feature) async {
    final existing = await ClassFeatureData.db.find(
      session,
      where: (t) => t.id.equals(feature.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      feature.id = old.id;
      feature.version = (old.version ?? 0) + 1;
      feature.createdAt = old.createdAt ?? now;
      feature.updatedAt = now;

      await ClassFeatureData.db.updateRow(session, feature);
      return feature;
    } else {
      feature.version = feature.version ?? 1;
      feature.createdAt = now;
      feature.updatedAt = now;

      return await ClassFeatureData.db.insertRow(session, feature);
    }
  }

  Future<void> delete(Session session, int id) async {
    await ClassFeatureData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class SubclassDataEndpoint extends Endpoint {
  Future<List<SubclassData>> getAll(Session session) async {
    return await SubclassData.db.find(session);
  }

  Future<SubclassData> add(Session session, SubclassData item) async {
    return await SubclassData.db.insertRow(session, item);
  }

  Future<SubclassData> upsert(Session session, SubclassData subclass) async {
    final existing = await SubclassData.db.find(
      session,
      where: (t) => t.id.equals(subclass.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      subclass.id = old.id;
      subclass.version = (old.version ?? 0) + 1;
      subclass.createdAt = old.createdAt ?? now;
      subclass.updatedAt = now;

      await SubclassData.db.updateRow(session, subclass);
      return subclass;
    } else {
      subclass.version = subclass.version ?? 1;
      subclass.createdAt = now;
      subclass.updatedAt = now;

      return await SubclassData.db.insertRow(session, subclass);
    }
  }

  Future<void> delete(Session session, int id) async {
    await SubclassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class ClassOptionDataEndpoint extends Endpoint {
  Future<List<ClassOptionData>> getAll(Session session) async {
    return await ClassOptionData.db.find(session);
  }

  Future<ClassOptionData> add(Session session, ClassOptionData item) async {
    return await ClassOptionData.db.insertRow(session, item);
  }

  Future<ClassOptionData> upsert(
      Session session, ClassOptionData classOption) async {
    final existing = await ClassOptionData.db.find(
      session,
      where: (t) => t.id.equals(classOption.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      classOption.id = old.id;
      classOption.version = (old.version ?? 0) + 1;
      classOption.createdAt = old.createdAt ?? now;
      classOption.updatedAt = now;

      await ClassOptionData.db.updateRow(session, classOption);
      return classOption;
    } else {
      classOption.version = classOption.version ?? 1;
      classOption.createdAt = now;
      classOption.updatedAt = now;

      return await ClassOptionData.db.insertRow(session, classOption);
    }
  }

  Future<void> delete(Session session, int id) async {
    await ClassOptionData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class SubclassFeatureDataEndpoint extends Endpoint {
  Future<List<SubclassFeatureData>> getAll(Session session) async {
    return await SubclassFeatureData.db.find(session);
  }

  Future<SubclassFeatureData> add(
      Session session, SubclassFeatureData item) async {
    return await SubclassFeatureData.db.insertRow(session, item);
  }

  Future<SubclassFeatureData> upsert(
      Session session, SubclassFeatureData subclassFeature) async {
    final existing = await SubclassFeatureData.db.find(
      session,
      where: (t) => t.id.equals(subclassFeature.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      subclassFeature.id = old.id;
      subclassFeature.version = (old.version ?? 0) + 1;
      subclassFeature.createdAt = old.createdAt ?? now;
      subclassFeature.updatedAt = now;

      await SubclassFeatureData.db.updateRow(session, subclassFeature);
      return subclassFeature;
    } else {
      subclassFeature.version = subclassFeature.version ?? 1;
      subclassFeature.createdAt = now;
      subclassFeature.updatedAt = now;

      return await SubclassFeatureData.db.insertRow(session, subclassFeature);
    }
  }

  Future<void> delete(Session session, int id) async {
    await SubclassFeatureData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
