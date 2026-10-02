import 'package:characters_mirror_flutter/core/ui/widgets/character_mirror_logo.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.child,
    this.footer,
    super.key,
  });

  final String title;
  final Widget child;
  final Widget? footer;

  static const _horizontalPadding = 24.0;
  static const _topPadding = 32.0;
  static const _bottomPadding = 24.0;
  static const _formMaxWidth = 440.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight =
                (constraints.maxHeight - _topPadding - _bottomPadding)
                    .clamp(0.0, double.infinity);
            final availableWidth =
                (constraints.maxWidth - _horizontalPadding * 2)
                    .clamp(0.0, double.infinity);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
              ).copyWith(top: _topPadding, bottom: _bottomPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: availableHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(child: CharacterMirrorLogo(size: 256)),
                      const SizedBox(height: 10),
                      Text(
                        'Character\'s Mirror',
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      if (footer != null)
                        const Spacer()
                      else
                        const SizedBox(height: 32),
                      Center(
                        child: SizedBox(
                          width: availableWidth.clamp(0.0, _formMaxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 24),
                              child,
                            ],
                          ),
                        ),
                      ),
                      if (footer != null) ...[
                        const Spacer(),
                        Center(
                          child: SizedBox(
                            width: availableWidth.clamp(0.0, _formMaxWidth),
                            child: footer!,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AuthInlineMessage extends StatelessWidget {
  const AuthInlineMessage({
    required this.message,
    required this.isError,
    super.key,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = isError
        ? colorScheme.error.withValues(alpha: 0.14)
        : colorScheme.surfaceContainerHigh;
    final foreground =
        isError ? colorScheme.error : colorScheme.onSurfaceVariant;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: foreground.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: foreground,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
