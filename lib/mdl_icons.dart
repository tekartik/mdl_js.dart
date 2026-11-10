/// Material icons.
@Deprecated('Do no use')
library;

import 'package:web/web.dart' as web;

import 'src/dom_prv.dart';

/// The material icons class.
const String materialIcons = 'material-icons';

/// The person icon.
const String iconPerson = 'person';

/// A new [tag] element showing [icon].
web.Element newIcon(String? icon, {String tag = 'i'}) {
  final iElement = createElementWithClasses(tag, [materialIcons]);
  if (icon != null) {
    iElement.textContent = icon;
  }
  return iElement;
}
