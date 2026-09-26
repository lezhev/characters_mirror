import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders inside an unbounded scrollable parent', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: errorWidget(
                e: StateError('Test failure'),
                s: StackTrace.empty,
                refresh: () {},
                context: context,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Попробовать снова'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
