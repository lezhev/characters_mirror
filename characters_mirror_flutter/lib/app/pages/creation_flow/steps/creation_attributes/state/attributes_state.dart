import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/common/attribute_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attributes_state.g.dart';
part 'attributes_state.freezed.dart';

enum SelectType { random, defaultType, byHand, purchase }

extension SelectTypeTitle on SelectType {
  String get title {
    switch (this) {
      case SelectType.random:
        return 'Случайно';
      case SelectType.defaultType:
        return 'Стандартно';
      case SelectType.byHand:
        return 'Вручную';
      case SelectType.purchase:
        return 'Закупка';
    }
  }
}

@freezed
sealed class AttributesStateModel with _$AttributesStateModel {
  factory AttributesStateModel(
      {@Default(SelectType.defaultType) SelectType selectionType,
      @Default({}) Map<Attribute, int> attributes}) = _AttributesStateModel;
}

@Riverpod(keepAlive: true)
class AttributesState extends _$AttributesState {
  @override
  AttributesStateModel build() {
    return AttributesStateModel();
  }

  void changeAttributes(Map<Attribute, int> attributes) {
    state = state.copyWith(attributes: attributes);
  }

  void changeType(SelectType type) {
    state = state.copyWith(selectionType: type);
  }
}
