import 'package:characters_mirror_flutter/core/app/characters_mirror_app.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

void main() async {
  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  await initializeServerpodClient();
  runApp(const ProviderScope(child: CharactersMirrorApp()));
}
