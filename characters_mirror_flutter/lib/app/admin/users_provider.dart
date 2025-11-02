import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

final usersProvider = FutureProvider<List<UserInfo>>((ref) async {
  return await client.admin.getAllUsers();
});
