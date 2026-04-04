import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

Widget errorWidget(
    {required Object e,
    required StackTrace s,
    required VoidCallback refresh,
    required BuildContext context}) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 8),
          SelectableText(
            humanReadableError(e),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: refresh,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    ),
  );
}

String humanReadableError(Object e) {
  if (e is ServerpodClientException) {
    if (e.message.contains('Failed to fetch')) {
      return 'Не удалось подключиться к серверу. Проверьте соединение.';
    }
    if (e.message.contains('Unknown server response code')) {
      return 'Сервер вернул неожиданный ответ.';
    }
    return 'Ошибка сервера: ${e.message}';
  }

  if (e is TimeoutException) {
    return 'Превышено время ожидания сервера.';
  }

  // Можно добавить другие типы ошибок
  return 'Произошла непредвиденная ошибка \n ${e.toString()}.';
}
