import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;

/// Produces text only: never renders markup, loads URLs, or evaluates rolls.
String foundryDescriptionText(String source) {
  final linked = source
      .replaceAllMapped(
        RegExp(r'@(?:Compendium|UUID)\[[^\]]*\]\{([^}]*)\}'),
        (match) => match[1]!,
      )
      .replaceAllMapped(
        RegExp(r'\[\[\s*/(?:r|roll|gmroll|br|blindroll)\s+([^\]]+)\]\]'),
        (match) => match[1]!,
      );
  final fragment = html.parseFragment(linked);
  final output = StringBuffer();
  const blocks = {
    'p',
    'div',
    'section',
    'li',
    'br',
    'hr',
    'h1',
    'h2',
    'h3',
    'tr'
  };
  void visit(Node node) {
    if (node is Text) {
      output.write(node.data);
      return;
    }
    if (node is Element) {
      // Secret sections deliberately remain: this is the GM's library.
      if ({'script', 'style', 'iframe', 'object'}.contains(node.localName)) {
        return;
      }
      if (blocks.contains(node.localName)) output.write('\n');
      for (final child in node.nodes) {
        visit(child);
      }
      if (blocks.contains(node.localName)) output.write('\n');
      return;
    }
    for (final child in node.nodes) {
      visit(child);
    }
  }

  visit(fragment);
  return output
      .toString()
      .replaceAll('\u00a0', ' ')
      .replaceAll(RegExp(r'[ \t]+'), ' ')
      .replaceAll(RegExp(r' *\n *'), '\n')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}
