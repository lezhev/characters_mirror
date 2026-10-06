import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    required this.onChanged,
    this.labelText = 'Поиск',
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
