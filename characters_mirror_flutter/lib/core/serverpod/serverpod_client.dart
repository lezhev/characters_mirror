import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/remember_me_persistence.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late SessionManager sessionManager;
late Client client;
late RememberMePersistenceController rememberMePersistenceController;

Future<void> initializeServerpodClient() async {
  const serverUrl = String.fromEnvironment(
    'CM_SERVER_URL',
    defaultValue: kIsWeb ? 'http://localhost:8083/' : 'http://10.0.2.2:8083/',
  );

  // Sets up a singleton client object that can be used to talk to the server from
  // anywhere in our app. The client is generated from your server code.
  // The client is set up to connect to a Serverpod running on a local server on
  // the default port. You will need to modify this to connect to staging or
  // production servers.
  final rememberMeStorage = RememberMeStorage();
  final rememberMeKeyManager = RememberMeAuthenticationKeyManager();
  rememberMePersistenceController = RememberMePersistenceController(
    keyManager: rememberMeKeyManager,
    storage: rememberMeStorage,
  );

  client = Client(
    serverUrl,
    authenticationKeyManager: rememberMeKeyManager,
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // The session manager keeps track of the signed-in state of the user. You
  // can query it to see if the user is currently signed in and get information
  // about the user.
  sessionManager = SessionManager(
    caller: client.modules.auth,
    storage: rememberMeStorage,
  );

  await sessionManager.initialize();
}
