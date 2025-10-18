import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client('http://localhost:8083/')
    ..connectivityMonitor = FlutterConnectivityMonitor();

  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  final Client client;
  const MyApp(this.client, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CharacterListPage(client: client),
    );
  }
}

class CharacterListPage extends StatefulWidget {
  final Client client;
  const CharacterListPage({super.key, required this.client});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late Future<List<Character>> _characters;

  @override
  void initState() {
    super.initState();
    _characters = widget.client.character.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: FutureBuilder<List<Character>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: SelectableText('Ошибка: ${snapshot.error}'));
          }
          final characters = snapshot.data ?? [];
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, i) {
              final c = characters[i];
              return ListTile(
                title: Text(c.name),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final testChar = Character(name: 'Test Hero', userId: 1);
          await widget.client.character.add(testChar);
          setState(() {
            _characters = widget.client.character.getAll();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
