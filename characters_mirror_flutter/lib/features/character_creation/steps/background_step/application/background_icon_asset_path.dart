const _backgroundIconFiles = <String, String>{
  'Послушник': 'acolyte',
  'Шарлатан': 'charlatan',
  'Преступник': 'criminal',
  'Артист': 'entertainer',
  'Народный герой': 'folk_hero',
  'Гильдейский ремесленник': 'guild artisan',
  'Отшельник': 'hermit',
  'Благородный': 'noble',
  'Чужеземец': 'outlander',
  'Пират': 'pirate',
  'Мудрец': 'sage',
  'Моряк': 'sailor',
  'Солдат': 'soldier',
  'Беспризорник': 'urchin',
};

String backgroundIconAssetPath(String? backgroundName) {
  final iconFile = _backgroundIconFiles[backgroundName?.trim()];
  if (iconFile == null) return 'assets/svg/placeholder.svg';

  return 'assets/svg/backgrounds/$iconFile.svg';
}
