import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock_models.dart';

class DmStatblockItem extends StatefulWidget {
  const DmStatblockItem(
      {super.key, required this.item, this.descriptionBuilder});
  final DmItemView item;
  final WidgetBuilder? descriptionBuilder;
  @override
  State<DmStatblockItem> createState() => _DmStatblockItemState();
}

class _DmStatblockItemState extends State<DmStatblockItem>
    with SingleTickerProviderStateMixin {
  bool _expanded = false, _opened = false;
  late final AnimationController _controller;
  late final CurvedAnimation _size;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _size = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _opened = true;
    });
    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant DmStatblockItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id ||
        oldWidget.item.description != widget.item.description) {
      _expanded = false;
      _opened = false;
      _controller.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), item = widget.item;
    final secondaryStyle = theme.textTheme.bodySmall
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final expandable = item.description.trim().isNotEmpty;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Semantics(
          button: expandable,
          expanded: expandable ? _expanded : null,
          child: InkWell(
              onTap: expandable ? _toggle : null,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(item.name,
                                  style: theme.textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              if (!_expanded && item.summary.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(item.summary, style: secondaryStyle)
                              ],
                            ])),
                        if (item.costLabel != null) ...[
                          const SizedBox(width: 8),
                          Text(item.costLabel!,
                              style: theme.textTheme.bodySmall)
                        ],
                        if (expandable) ...[
                          const SizedBox(width: 8),
                          AnimatedRotation(
                              turns: _expanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(Icons.expand_more,
                                  color: theme.colorScheme.onSurfaceVariant,
                                  size: 22)),
                        ],
                      ]))))),
      if (_opened)
        AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Offstage(
                offstage: _controller.isDismissed,
                child: SizeTransition(
                    sizeFactor: _size,
                    axisAlignment: -1,
                    child: FadeTransition(opacity: _size, child: child))),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.descriptionBuilder != null)
                        widget.descriptionBuilder!(context)
                      else if (item.description.isNotEmpty)
                        SelectableText(item.description,
                            key: PageStorageKey('${item.id}:description'),
                            style: secondaryStyle),
                    ]))),
    ]);
  }

  @override
  void dispose() {
    _size.dispose();
    _controller.dispose();
    super.dispose();
  }
}
