import 'package:flutter/material.dart';

class RollResultsOverlay extends StatefulWidget {
  const RollResultsOverlay({
    required this.child,
    super.key,
    this.maxVisibleMessages = 8,
  });

  final Widget child;
  final int maxVisibleMessages;

  static void show(BuildContext context, String message) {
    context.findAncestorStateOfType<_RollResultsOverlayState>()?.show(message);
  }

  @override
  State<RollResultsOverlay> createState() => _RollResultsOverlayState();
}

class _RollResultsOverlayState extends State<RollResultsOverlay> {
  final List<_RollResultMessage> _messages = [];
  var _nextId = 0;

  void show(String text) {
    setState(() {
      _messages.add(_RollResultMessage(id: _nextId++, text: text));
      if (_messages.length > widget.maxVisibleMessages) {
        _messages.removeRange(
          0,
          _messages.length - widget.maxVisibleMessages,
        );
      }
    });
  }

  void _closeAll() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 12,
          bottom: 12,
          child: SafeArea(
            minimum: const EdgeInsets.only(left: 12),
            child: _RollResultStack(
              messages: _messages,
              onClose: _closeAll,
            ),
          ),
        ),
      ],
    );
  }
}

class _RollResultStack extends StatelessWidget {
  const _RollResultStack({
    required this.messages,
    required this.onClose,
  });

  final List<_RollResultMessage> messages;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: messages.isEmpty,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final message in messages) ...[
              _RollResultToast(
                key: ValueKey('roll-result-${message.id}'),
                message: message,
                showCloseButton: message == messages.last,
                onClose: onClose,
              ),
              if (message != messages.last) const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _RollResultToast extends StatelessWidget {
  const _RollResultToast({
    required this.message,
    required this.showCloseButton,
    required this.onClose,
    super.key,
  });

  final _RollResultMessage message;
  final bool showCloseButton;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor =
        colorScheme.surfaceContainerHighest.withAlpha((255 * 0.92).round());
    final foregroundColor = colorScheme.onSurfaceVariant;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          top: 8,
          right: showCloseButton ? 0 : 12,
          bottom: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                message.text,
                key: const ValueKey('roll-result-message'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                ),
              ),
            ),
            if (showCloseButton)
              Semantics(
                label: 'Закрыть',
                button: true,
                child: IconButton(
                  key: const ValueKey('roll-result-close'),
                  onPressed: onClose,
                  icon: const Icon(Icons.close_rounded),
                  color: foregroundColor,
                  visualDensity: VisualDensity.compact,
                  tooltip: null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RollResultMessage {
  const _RollResultMessage({
    required this.id,
    required this.text,
  });

  final int id;
  final String text;
}
