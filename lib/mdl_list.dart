library tekartik.mdj_js.list;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;
import 'mdl_icons.dart';

html.Element listCreate({bool mega}) {
  List<String> classes = [mdl.list];
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

html.Element listItemCreate({bool threeLine}) {
  List<String> classes = [mdl.listItem];

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

html.Element listItemPrimaryContentCreate({String tag = "span"}) {
  List<String> classes = [mdl.listItemPrimaryContent];
  html.Element button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemSecondaryContentCreate({String tag = "span"}) {
  List<String> classes = [mdl.listItemSecondaryContent];
  html.Element button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemSecondaryActionCreate({String tag = "a"}) {
  List<String> classes = [mdl.listItemSecondaryAction];
  html.Element button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemTextBodyCreate({String tag = "span"}) {
  List<String> classes = [mdl.listItemTextBody];
  html.Element button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

html.Element listItemAvatarCreate(
    {String tag = "i", String icon = iconPerson}) {
  List<String> classes = [mdl.listItemAvatar];
  if (icon != null) {
    classes.add(materialIcons);
  }
  html.Element iElement = html.Element.tag(tag)..classes.addAll(classes);
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
