// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassStateModel {
  List<ClassData> get allClasses;
  ClassData? get selectedClass;
  List<SubclassData> get subclasses;
  SubclassData? get selectedSubclass;
  List<ClassFeatureData> get features;
  List<ClassFeatureData> get futureFeatures;
  List<ClassOptionData> get classOptions;
  Map<int, ClassOptionData>? get selectedOption;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassStateModelCopyWith<ClassStateModel> get copyWith =>
      _$ClassStateModelCopyWithImpl<ClassStateModel>(
          this as ClassStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassStateModel &&
            const DeepCollectionEquality()
                .equals(other.allClasses, allClasses) &&
            (identical(other.selectedClass, selectedClass) ||
                other.selectedClass == selectedClass) &&
            const DeepCollectionEquality()
                .equals(other.subclasses, subclasses) &&
            (identical(other.selectedSubclass, selectedSubclass) ||
                other.selectedSubclass == selectedSubclass) &&
            const DeepCollectionEquality().equals(other.features, features) &&
            const DeepCollectionEquality()
                .equals(other.futureFeatures, futureFeatures) &&
            const DeepCollectionEquality()
                .equals(other.classOptions, classOptions) &&
            const DeepCollectionEquality()
                .equals(other.selectedOption, selectedOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allClasses),
      selectedClass,
      const DeepCollectionEquality().hash(subclasses),
      selectedSubclass,
      const DeepCollectionEquality().hash(features),
      const DeepCollectionEquality().hash(futureFeatures),
      const DeepCollectionEquality().hash(classOptions),
      const DeepCollectionEquality().hash(selectedOption));

  @override
  String toString() {
    return 'ClassStateModel(allClasses: $allClasses, selectedClass: $selectedClass, subclasses: $subclasses, selectedSubclass: $selectedSubclass, features: $features, futureFeatures: $futureFeatures, classOptions: $classOptions, selectedOption: $selectedOption)';
  }
}

/// @nodoc
abstract mixin class $ClassStateModelCopyWith<$Res> {
  factory $ClassStateModelCopyWith(
          ClassStateModel value, $Res Function(ClassStateModel) _then) =
      _$ClassStateModelCopyWithImpl;
  @useResult
  $Res call(
      {List<ClassData> allClasses,
      ClassData? selectedClass,
      List<SubclassData> subclasses,
      SubclassData? selectedSubclass,
      List<ClassFeatureData> features,
      List<ClassFeatureData> futureFeatures,
      List<ClassOptionData> classOptions,
      Map<int, ClassOptionData>? selectedOption});
}

/// @nodoc
class _$ClassStateModelCopyWithImpl<$Res>
    implements $ClassStateModelCopyWith<$Res> {
  _$ClassStateModelCopyWithImpl(this._self, this._then);

  final ClassStateModel _self;
  final $Res Function(ClassStateModel) _then;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allClasses = null,
    Object? selectedClass = freezed,
    Object? subclasses = null,
    Object? selectedSubclass = freezed,
    Object? features = null,
    Object? futureFeatures = null,
    Object? classOptions = null,
    Object? selectedOption = freezed,
  }) {
    return _then(_self.copyWith(
      allClasses: null == allClasses
          ? _self.allClasses
          : allClasses // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
      selectedClass: freezed == selectedClass
          ? _self.selectedClass
          : selectedClass // ignore: cast_nullable_to_non_nullable
              as ClassData?,
      subclasses: null == subclasses
          ? _self.subclasses
          : subclasses // ignore: cast_nullable_to_non_nullable
              as List<SubclassData>,
      selectedSubclass: freezed == selectedSubclass
          ? _self.selectedSubclass
          : selectedSubclass // ignore: cast_nullable_to_non_nullable
              as SubclassData?,
      features: null == features
          ? _self.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<ClassFeatureData>,
      futureFeatures: null == futureFeatures
          ? _self.futureFeatures
          : futureFeatures // ignore: cast_nullable_to_non_nullable
              as List<ClassFeatureData>,
      classOptions: null == classOptions
          ? _self.classOptions
          : classOptions // ignore: cast_nullable_to_non_nullable
              as List<ClassOptionData>,
      selectedOption: freezed == selectedOption
          ? _self.selectedOption
          : selectedOption // ignore: cast_nullable_to_non_nullable
              as Map<int, ClassOptionData>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassStateModel].
extension ClassStateModelPatterns on ClassStateModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClassStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClassStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClassStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            List<SubclassData> subclasses,
            SubclassData? selectedSubclass,
            List<ClassFeatureData> features,
            List<ClassFeatureData> futureFeatures,
            List<ClassOptionData> classOptions,
            Map<int, ClassOptionData>? selectedOption)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.subclasses,
            _that.selectedSubclass,
            _that.features,
            _that.futureFeatures,
            _that.classOptions,
            _that.selectedOption);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            List<SubclassData> subclasses,
            SubclassData? selectedSubclass,
            List<ClassFeatureData> features,
            List<ClassFeatureData> futureFeatures,
            List<ClassOptionData> classOptions,
            Map<int, ClassOptionData>? selectedOption)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel():
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.subclasses,
            _that.selectedSubclass,
            _that.features,
            _that.futureFeatures,
            _that.classOptions,
            _that.selectedOption);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            List<SubclassData> subclasses,
            SubclassData? selectedSubclass,
            List<ClassFeatureData> features,
            List<ClassFeatureData> futureFeatures,
            List<ClassOptionData> classOptions,
            Map<int, ClassOptionData>? selectedOption)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.subclasses,
            _that.selectedSubclass,
            _that.features,
            _that.futureFeatures,
            _that.classOptions,
            _that.selectedOption);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ClassStateModel implements ClassStateModel {
  const _ClassStateModel(
      {final List<ClassData> allClasses = const [],
      this.selectedClass,
      final List<SubclassData> subclasses = const [],
      this.selectedSubclass,
      final List<ClassFeatureData> features = const [],
      final List<ClassFeatureData> futureFeatures = const [],
      final List<ClassOptionData> classOptions = const [],
      final Map<int, ClassOptionData>? selectedOption})
      : _allClasses = allClasses,
        _subclasses = subclasses,
        _features = features,
        _futureFeatures = futureFeatures,
        _classOptions = classOptions,
        _selectedOption = selectedOption;

  final List<ClassData> _allClasses;
  @override
  @JsonKey()
  List<ClassData> get allClasses {
    if (_allClasses is EqualUnmodifiableListView) return _allClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allClasses);
  }

  @override
  final ClassData? selectedClass;
  final List<SubclassData> _subclasses;
  @override
  @JsonKey()
  List<SubclassData> get subclasses {
    if (_subclasses is EqualUnmodifiableListView) return _subclasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subclasses);
  }

  @override
  final SubclassData? selectedSubclass;
  final List<ClassFeatureData> _features;
  @override
  @JsonKey()
  List<ClassFeatureData> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  final List<ClassFeatureData> _futureFeatures;
  @override
  @JsonKey()
  List<ClassFeatureData> get futureFeatures {
    if (_futureFeatures is EqualUnmodifiableListView) return _futureFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_futureFeatures);
  }

  final List<ClassOptionData> _classOptions;
  @override
  @JsonKey()
  List<ClassOptionData> get classOptions {
    if (_classOptions is EqualUnmodifiableListView) return _classOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classOptions);
  }

  final Map<int, ClassOptionData>? _selectedOption;
  @override
  Map<int, ClassOptionData>? get selectedOption {
    final value = _selectedOption;
    if (value == null) return null;
    if (_selectedOption is EqualUnmodifiableMapView) return _selectedOption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClassStateModelCopyWith<_ClassStateModel> get copyWith =>
      __$ClassStateModelCopyWithImpl<_ClassStateModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClassStateModel &&
            const DeepCollectionEquality()
                .equals(other._allClasses, _allClasses) &&
            (identical(other.selectedClass, selectedClass) ||
                other.selectedClass == selectedClass) &&
            const DeepCollectionEquality()
                .equals(other._subclasses, _subclasses) &&
            (identical(other.selectedSubclass, selectedSubclass) ||
                other.selectedSubclass == selectedSubclass) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            const DeepCollectionEquality()
                .equals(other._futureFeatures, _futureFeatures) &&
            const DeepCollectionEquality()
                .equals(other._classOptions, _classOptions) &&
            const DeepCollectionEquality()
                .equals(other._selectedOption, _selectedOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allClasses),
      selectedClass,
      const DeepCollectionEquality().hash(_subclasses),
      selectedSubclass,
      const DeepCollectionEquality().hash(_features),
      const DeepCollectionEquality().hash(_futureFeatures),
      const DeepCollectionEquality().hash(_classOptions),
      const DeepCollectionEquality().hash(_selectedOption));

  @override
  String toString() {
    return 'ClassStateModel(allClasses: $allClasses, selectedClass: $selectedClass, subclasses: $subclasses, selectedSubclass: $selectedSubclass, features: $features, futureFeatures: $futureFeatures, classOptions: $classOptions, selectedOption: $selectedOption)';
  }
}

/// @nodoc
abstract mixin class _$ClassStateModelCopyWith<$Res>
    implements $ClassStateModelCopyWith<$Res> {
  factory _$ClassStateModelCopyWith(
          _ClassStateModel value, $Res Function(_ClassStateModel) _then) =
      __$ClassStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ClassData> allClasses,
      ClassData? selectedClass,
      List<SubclassData> subclasses,
      SubclassData? selectedSubclass,
      List<ClassFeatureData> features,
      List<ClassFeatureData> futureFeatures,
      List<ClassOptionData> classOptions,
      Map<int, ClassOptionData>? selectedOption});
}

/// @nodoc
class __$ClassStateModelCopyWithImpl<$Res>
    implements _$ClassStateModelCopyWith<$Res> {
  __$ClassStateModelCopyWithImpl(this._self, this._then);

  final _ClassStateModel _self;
  final $Res Function(_ClassStateModel) _then;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allClasses = null,
    Object? selectedClass = freezed,
    Object? subclasses = null,
    Object? selectedSubclass = freezed,
    Object? features = null,
    Object? futureFeatures = null,
    Object? classOptions = null,
    Object? selectedOption = freezed,
  }) {
    return _then(_ClassStateModel(
      allClasses: null == allClasses
          ? _self._allClasses
          : allClasses // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
      selectedClass: freezed == selectedClass
          ? _self.selectedClass
          : selectedClass // ignore: cast_nullable_to_non_nullable
              as ClassData?,
      subclasses: null == subclasses
          ? _self._subclasses
          : subclasses // ignore: cast_nullable_to_non_nullable
              as List<SubclassData>,
      selectedSubclass: freezed == selectedSubclass
          ? _self.selectedSubclass
          : selectedSubclass // ignore: cast_nullable_to_non_nullable
              as SubclassData?,
      features: null == features
          ? _self._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<ClassFeatureData>,
      futureFeatures: null == futureFeatures
          ? _self._futureFeatures
          : futureFeatures // ignore: cast_nullable_to_non_nullable
              as List<ClassFeatureData>,
      classOptions: null == classOptions
          ? _self._classOptions
          : classOptions // ignore: cast_nullable_to_non_nullable
              as List<ClassOptionData>,
      selectedOption: freezed == selectedOption
          ? _self._selectedOption
          : selectedOption // ignore: cast_nullable_to_non_nullable
              as Map<int, ClassOptionData>?,
    ));
  }
}

// dart format on
