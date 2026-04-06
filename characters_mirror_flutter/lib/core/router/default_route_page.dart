import 'package:flutter/material.dart';

class DefaultRoutePage extends StatelessWidget {
  const DefaultRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
