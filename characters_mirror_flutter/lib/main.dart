import 'package:characters_mirror_flutter/app/router/router_provider.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient(); // твоя инициализация Serverpod Client
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Characters Mirror',
      routerConfig: router,
      theme: darkTheme,
    );
  }
}
