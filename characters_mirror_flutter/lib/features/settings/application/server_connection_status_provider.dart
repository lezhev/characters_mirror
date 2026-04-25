import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ServerConnectionStatus {
  online,
  offline,
}

final serverConnectionStatusProvider =
    FutureProvider.autoDispose<ServerConnectionStatus>((ref) async {
  try {
    final isOnline = await client.ping.ping().timeout(
          const Duration(seconds: 3),
        );
    return isOnline
        ? ServerConnectionStatus.online
        : ServerConnectionStatus.offline;
  } catch (_) {
    return ServerConnectionStatus.offline;
  }
});
