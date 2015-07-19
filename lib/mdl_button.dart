library tekartik.mdj_js.button;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.Element buttonCreate({bool ripple: true, bool raised, bool colored, String tag : 'button'}) {
  List<String> classes = [mdl.button, mdl.jsButton];
  if (ripple == true) {
    classes.add(mdl.jsRippleEffect);
  }
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }
  if (colored == true) {
    classes.add(mdl.buttonColored);
  }

  html.Element button = new html.Element.tag(tag)
    ..classes.addAll(classes);
  return button;
}

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