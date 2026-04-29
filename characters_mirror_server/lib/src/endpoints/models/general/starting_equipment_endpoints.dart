import 'package:characters_mirror_server/src/generated/protocol.dart';

List<StartingEquipmentBlockView> startingEquipmentBlockViews(
  List<StartingEquipmentBlockData>? blocks,
) {
  final sortedBlocks = [...?blocks]
    ..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));

  return [
    for (final block in sortedBlocks)
      StartingEquipmentBlockView(
        block: block,
        fixedLines: _sortedLines(block.fixedLines),
        options: [
          for (final option in _sortedOptions(block.options))
            StartingEquipmentOptionView(
              option: option,
              lines: _sortedLines(option.lines),
            ),
        ],
      ),
  ];
}

List<StartingEquipmentOptionData> _sortedOptions(
  List<StartingEquipmentOptionData>? options,
) {
  return [...?options]
    ..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
}

List<StartingEquipmentLineData> _sortedLines(
  List<StartingEquipmentLineData>? lines,
) {
  return [...?lines]
    ..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
}
