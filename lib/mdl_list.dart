library tekartik.mdj_js.list;

import 'dart:html' as html;

import 'mdl_icons.dart';
import 'src/import.dart' as mdl;

html.Element listCreate({bool? mega}) {
  final classes = [mdl.list];
  /*
  if (ripple == true) {
    classes.add(mdl.jsRippleEffect);
  }
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }
  if (colored == true) {
    classes.add(mdl.buttonColored);
  }
  */
  html.Element button = html.UListElement()..classes.addAll(classes);
  return button;
}

html.Element listItemCreate({bool? threeLine}) {
  final classes = [mdl.listItem];

  if (threeLine == true) {
    classes.add(mdl.listItemThreeLine);
  }
  /*
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }
  if (colored == true) {
    classes.add(mdl.buttonColored);
  }
  */
  html.Element button = html.LIElement()..classes.addAll(classes);
  return button;
}

html.Element listItemPrimaryContentCreate({String tag = 'span'}) {
  final classes = [mdl.listItemPrimaryContent];
  final button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemSecondaryContentCreate({String tag = 'span'}) {
  final classes = [mdl.listItemSecondaryContent];
  final button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemSecondaryActionCreate({String tag = 'a'}) {
  final classes = [mdl.listItemSecondaryAction];
  final button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemTextBodyCreate({String tag = 'span'}) {
  final classes = [mdl.listItemTextBody];
  final button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemAvatarCreate(
    {String tag = 'i', String? icon = iconPerson}) {
  final classes = [mdl.listItemAvatar];
  if (icon != null) {
    classes.add(materialIcons);
  }
  final iElement = html.Element.tag(tag)..classes.addAll(classes);
  if (icon != null) {
    iElement.text = icon;
  }
  return iElement;
}
/*

buttonUpgrade(html.Element button) {
  mdl.componentHandler.upgradeElement(button);
}

buttonSetActive(html.Element button, bool active) {
  if (active) {
    button.classes.add(mdl.isActive);
  } else {
    button.classes.remove(mdl.isActive);
  }
}
*/
