part of '../smooth_switcher.dart';

class _SmoothSwitcherState extends State<SmoothSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _fade;
  late Animation<double> _size;

  Widget? _currentChild;
  Object? _currentIdentity;
  final _key = GlobalKey();
  int _transitionRevision = 0;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
    _size = CurvedAnimation(parent: _c, curve: Curves.easeInOut);

    _currentIdentity = _identityFor(widget);
    _c.value = 1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentChild = _buildDisplayChild(context, widget);
  }

  @override
  void didUpdateWidget(covariant SmoothSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newIdentity = _identityFor(widget);
    if (newIdentity != _currentIdentity) {
      _runTransition(newIdentity);
      return;
    }

    _currentChild = _buildDisplayChild(context, widget);
  }

  Future<void> _runTransition(Object? newIdentity) async {
    final revision = ++_transitionRevision;
    if (_c.isAnimating) {
      _c.stop();
    }

    await _c.reverse();
    if (!mounted || revision != _transitionRevision) {
      return;
    }

    setState(() {
      _currentIdentity = newIdentity;
      _currentChild = _buildDisplayChild(context, widget);
    });

    await _c.forward();
    if (!mounted || revision != _transitionRevision) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || revision != _transitionRevision) {
        return;
      }
      _scrollToBottom();
    });
  }

  Object? _identityFor(SmoothSwitcher widget) {
    if (widget.switchKey != null) {
      return widget.switchKey;
    }
    if (widget.child != null) {
      return widget.child!.key ?? widget.child.runtimeType;
    }
    final abilityConfig = widget._abilityConfig;
    if (abilityConfig != null) {
      return Object.hashAll([
        widget.title,
        widget.text,
        abilityConfig.showTitle,
        abilityConfig.showText,
        abilityConfig.emptyTextPlaceholder,
        ...?abilityConfig.tags?.map((tag) => tag.name),
      ]);
    }
    return Object.hash(widget.title, widget.text);
  }

  Widget _buildDisplayChild(BuildContext context, SmoothSwitcher widget) {
    if (widget.child != null) {
      return widget.child!;
    }
    if (widget._abilityConfig != null) {
      return _buildAbilityChild(context, widget);
    }

    final hasTitle = widget.title != null && widget.title!.trim().isNotEmpty;
    final hasText = widget.text != null && widget.text!.trim().isNotEmpty;
    final isEditable = widget.editConfig != null;

    return Padding(
      padding: widget.contentPadding,
      child: Column(
        key: ValueKey<Object?>(_identityFor(widget)),
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          if (hasTitle)
            _EditableTextLine(
              text: widget.title!,
              style: widget.titleStyle,
              isEditable: isEditable,
              onTap: isEditable ? _openEditDialog : null,
            ),
          if (hasTitle && hasText) SizedBox(height: widget.spacing),
          if (hasText)
            _EditableTextLine(
              text: widget.text!,
              style: widget.textStyle,
              isEditable: isEditable,
              onTap: isEditable ? _openEditDialog : null,
            ),
        ],
      ),
    );
  }

  Widget _buildAbilityChild(BuildContext context, SmoothSwitcher widget) {
    final abilityConfig = widget._abilityConfig!;
    final theme = Theme.of(context);
    final title = _normalizedText(widget.title);
    final text = _normalizedText(widget.text);
    final hasTitle = abilityConfig.showTitle && title != null;
    final hasText = abilityConfig.showText && text != null;
    final showTextPlaceholder = abilityConfig.showText &&
        text == null &&
        abilityConfig.emptyTextPlaceholder != null;

    return Padding(
      padding: widget.contentPadding,
      child: Column(
        key: ValueKey<Object?>(_identityFor(widget)),
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          if (hasTitle)
            _EditableTextLine(
              text: title,
              style: widget.titleStyle,
              isEditable: true,
              onTap: _openEditDialog,
            ),
          if (hasTitle && (hasText || showTextPlaceholder))
            SizedBox(height: widget.spacing),
          if (hasText)
            _EditableTextLine(
              text: text,
              style: widget.textStyle,
              isEditable: true,
              onTap: _openEditDialog,
            ),
          if (showTextPlaceholder)
            _EditableTextLine(
              text: abilityConfig.emptyTextPlaceholder!,
              style: widget.textStyle?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ) ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              isEditable: true,
              onTap: _openEditDialog,
            ),
        ],
      ),
    );
  }

  Future<void> _openEditDialog() async {
    final editConfig = widget.editConfig;
    final abilityConfig = widget._abilityConfig;
    if (editConfig == null && abilityConfig == null) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        if (abilityConfig != null) {
          return _SmoothSwitcherAbilityDialog(
            abilityConfig: abilityConfig,
            initialTitle: widget.title,
            initialText: widget.text,
          );
        }
        return _SmoothSwitcherEditDialog(
          editConfig: editConfig!,
          initialTitle: widget.title,
          initialText: widget.text,
        );
      },
    );
  }

  void _scrollToBottom() {
    final ctx = _key.currentContext;
    if (ctx == null) {
      return;
    }

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: 1,
      alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    _currentChild ??= _buildDisplayChild(context, widget);

    return KeyedSubtree(
      key: _key,
      child: ClipRect(
        child: FadeTransition(
          opacity: _fade,
          child: AnimatedBuilder(
            animation: _size,
            builder: (context, child) {
              final t = _size.value;

              return Padding(
                padding: EdgeInsets.only(bottom: (1 - t) * 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: t.clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: _currentChild,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
}

class _EditableTextLine extends StatelessWidget {
  const _EditableTextLine({
    required this.text,
    required this.isEditable,
    this.style,
    this.onTap,
  });

  final String text;
  final TextStyle? style;
  final bool isEditable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      style: style,
      textAlign: TextAlign.start,
    );

    if (!isEditable) {
      return child;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: child,
      ),
    );
  }
}
