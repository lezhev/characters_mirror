import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

final authProvider = StateNotifierProvider<AuthNotifier, auth.UserInfo?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<auth.UserInfo?> {
  AuthNotifier() : super(null) {
    _init();
  }

  Future<void> _init() async {
    final sessionManager = await SessionManager.instance;
    if (sessionManager.isSignedIn) {
      state = sessionManager.signedInUser;
    }
  }

  Future<bool> signIn(String email, String password) async {
    final controller = EmailAuthController(client.modules.auth);
    final user = await controller.signIn(email, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    final sessionManager = await SessionManager.instance;
    await sessionManager.signOutDevice();
    state = null;
  }
}
