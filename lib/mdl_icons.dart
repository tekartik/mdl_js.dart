library tekartik.mdj_js.icons;

import 'dart:html' as html;

const String materialIcons = "material-icons";
const String iconPerson = "person";

html.Element newIcon(String icon, {String tag = "i"}) {
  List<String> classes = [materialIcons];

  html.Element iElement = html.Element.tag(tag)..classes.addAll(classes);
  if (icon != null) {
    iElement.text = icon;
  }
  return iElement;
}
