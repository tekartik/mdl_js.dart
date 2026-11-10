/// MDL list.
@Deprecated('Do no use')
library;

import 'package:web/web.dart' as web;

import 'mdl_icons.dart';
import 'src/dom_prv.dart';
import 'src/import.dart' as mdl;

/// A new list (`ul`).
web.Element listCreate({bool? mega}) {
  return createElementWithClasses('ul', [mdl.list]);
}

/// A new list item (`li`).
web.Element listItemCreate({bool? threeLine}) {
  final classes = [mdl.listItem];
  if (threeLine == true) {
    classes.add(mdl.listItemThreeLine);
  }
  return createElementWithClasses('li', classes);
}

/// The primary content of an item.
web.Element listItemPrimaryContentCreate({String tag = 'span'}) =>
    createElementWithClasses(tag, [mdl.listItemPrimaryContent]);

/// The secondary content of an item.
web.Element listItemSecondaryContentCreate({String tag = 'span'}) =>
    createElementWithClasses(tag, [mdl.listItemSecondaryContent]);

/// The secondary action of an item.
web.Element listItemSecondaryActionCreate({String tag = 'a'}) =>
    createElementWithClasses(tag, [mdl.listItemSecondaryAction]);

/// The text body of an item.
web.Element listItemTextBodyCreate({String tag = 'span'}) =>
    createElementWithClasses(tag, [mdl.listItemTextBody]);

/// The avatar of an item, showing [icon].
web.Element listItemAvatarCreate({
  String tag = 'i',
  String? icon = iconPerson,
}) {
  final classes = [mdl.listItemAvatar];
  if (icon != null) {
    classes.add(materialIcons);
  }
  final iElement = createElementWithClasses(tag, classes);
  if (icon != null) {
    iElement.textContent = icon;
  }
  return iElement;
}
