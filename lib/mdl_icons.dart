library;

import 'dart:html' as html;

const String materialIcons = 'material-icons';
const String iconPerson = 'person';

html.Element newIcon(String? icon, {String tag = 'i'}) {
  final classes = [materialIcons];

  final iElement = html.Element.tag(tag)..classes.addAll(classes);
  if (icon != null) {
    iElement.text = icon;
  }
  return iElement;
}
