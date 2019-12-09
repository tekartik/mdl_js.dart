library tekartik.mdj_js.button;

import 'dart:html' as html;
import 'mdl_classes.dart' as mdl;
import 'mdl_js.dart' as mdl;

html.Element buttonCreate(
    {bool ripple = true, bool raised, bool colored, String tag = 'button'}) {
  final classes = [mdl.button, mdl.jsButton];
  if (ripple == true) {
    classes.add(mdl.jsRippleEffect);
  }
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }
  if (colored == true) {
    classes.add(mdl.buttonColored);
  }

  final button = html.Element.tag(tag)..classes.addAll(classes);
  return button;
}

void buttonUpgrade(html.Element button) {
  mdl.componentHandler.upgradeElement(button);
}

void buttonSetActive(html.Element button, bool active) {
  if (active) {
    button.classes.add(mdl.isActive);
  } else {
    button.classes.remove(mdl.isActive);
  }
}
