import 'package:flutter/material.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Удалить запись?'),
      content: const Text('Вы уверены, что хотите удалить эту запись?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Удалить', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
