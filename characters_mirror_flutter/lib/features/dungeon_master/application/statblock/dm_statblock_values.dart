import 'dm_statblock_labels.dart';

Map<String, Object?> dmMap(Object? value) =>
    value is Map<String, Object?> ? value : const {};
String dmText(Object? value) => value is String
    ? value.trim()
    : value is num
        ? '$value'
        : '';
num? dmNumber(Object? value) {
  final number = value is num
      ? value
      : value is String
          ? num.tryParse(value.trim())
          : null;
  return number != null && number.isFinite ? number : null;
}

String dmSigned(num? value) => value == null
    ? '—'
    : value >= 0
        ? '+${dmText(value)}'
        : dmText(value);
int? dmModifier(Object? score) {
  final number = dmNumber(score);
  return number == null ? null : ((number - 10) / 2).floor();
}

/// Empty collections are absent; 0 and false are values. Domain defaults are
/// filtered by their own formatter rather than by this recursive predicate.
bool dmHasValue(Object? value) {
  if (value == null) return false;
  if (value is String) return value.trim().isNotEmpty;
  if (value is Map) return value.values.any(dmHasValue);
  if (value is List) return value.any(dmHasValue);
  return true;
}

num? dmBonus(Object? value) => !dmHasValue(value) ? 0 : dmNumber(value);
String dmLocalized(Object? value, Map<String, String> labels) {
  final text = dmText(value);
  return labels[text] ?? text;
}

String dmReadableArmorFormula(Object? value) {
  var text = dmText(value);
  for (final entry in dmAbilityLabels.entries) {
    text = text.replaceAll(
        '@abilities.${entry.key}.mod', 'модификатор ${entry.value}');
  }
  text = text
      .replaceAll('@attributes.ac.armor', 'КД доспеха')
      .replaceAll('@attributes.ac.dex', 'бонус ЛОВ к КД');
  return text.contains('@') ? '' : text;
}

String dmDistance(Map<String, Object?> range) {
  final units = dmLocalized(range['units'], dmUnitLabels);
  final value = dmText(range['value']);
  final long = dmNumber(range['long']) == 0 ? '' : dmText(range['long']);
  return [
    if (value.isNotEmpty) '$value${long.isEmpty ? '' : '/$long'}',
    if (value.isNotEmpty ||
        {'self', 'touch', 'any', 'spec'}.contains(range['units']))
      units
  ].where((s) => s.isNotEmpty).join(' ');
}

String dmTrait(Object? value, Map<String, String> labels) {
  final trait = dmMap(value);
  final values = trait['value'];
  final parts = <String>[
    if (values is List)
      ...values.map((v) => dmLocalized(v, labels)).where((s) => s.isNotEmpty),
    if (dmText(trait['custom']).isNotEmpty) dmText(trait['custom']),
  ];
  final bypass = trait['bypasses'];
  final exceptions = bypass is List
      ? bypass
          .map((v) => dmLocalized(v, {
                'mgc': 'магическое оружие',
                'sil': 'серебро',
                'ada': 'адамантин'
              }))
          .where((s) => s.isNotEmpty)
          .join(', ')
      : '';
  if (exceptions.isNotEmpty) parts.add('кроме: $exceptions');
  return parts.join('; ');
}

Uri? dmSafeImage(Object? value) {
  final uri = Uri.tryParse(dmText(value));
  return uri != null &&
          {'http', 'https'}.contains(uri.scheme) &&
          uri.host.isNotEmpty &&
          uri.userInfo.isEmpty
      ? uri
      : null;
}
