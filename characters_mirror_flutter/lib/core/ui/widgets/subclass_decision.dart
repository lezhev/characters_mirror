import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/character/subclass_presentation.dart';
import 'package:flutter/material.dart';
import 'choice_decision.dart';

class SubclassDecision extends StatelessWidget {
  const SubclassDecision(
      {super.key,
      required this.subclasses,
      required this.selectedId,
      required this.context,
      required this.onChanged});
  final List<SubclassData> subclasses;
  final int? selectedId;
  final ChoicePresentationContext context;
  final ValueChanged<int?> onChanged;
  @override
  Widget build(BuildContext buildContext) => ChoiceDecision(
      presentation: subclassChoicePresentation(subclasses, selectedId),
      context: context,
      onChanged: (keys) =>
          onChanged(keys.isEmpty ? null : int.parse(keys.single)));
}
