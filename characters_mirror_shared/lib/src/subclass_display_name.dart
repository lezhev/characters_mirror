/// Combines the stored archetype and grammatical name without inflecting it.
String? subclassDisplayName(String? archetype, String? name) {
  final prefix = archetype?.trim() ?? '';
  var suffix = name?.trim() ?? '';
  if (prefix.isEmpty) return suffix.isEmpty ? null : suffix;
  if (suffix.isEmpty) return prefix;
  if (suffix.toLowerCase() == prefix.toLowerCase() ||
      suffix.toLowerCase().startsWith('${prefix.toLowerCase()} ')) {
    return suffix;
  }
  // These archetypes take a common-noun complement; proper names stay intact.
  if (const {'школа', 'клятва'}.contains(prefix.toLowerCase())) {
    suffix = '${suffix[0].toLowerCase()}${suffix.substring(1)}';
  }
  return '$prefix $suffix';
}
