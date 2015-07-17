library tekartik.mdj_js.button;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.ButtonElement buttonCreate({bool ripple: true}) {
  List<String> classes = [mdl.button, mdl.jsButton];
  if (ripple == true) {
    classes.add(mdl.jsRippleEffect);
  }

  html.ButtonElement button = new html.ButtonElement()
  ..classes.addAll(classes);
  return button;
}

buttonUpgrade(html.ButtonElement button) {
  mdl.componentHandler.upgradeElement(button);
}
