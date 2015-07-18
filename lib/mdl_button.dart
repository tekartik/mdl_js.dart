library tekartik.mdj_js.button;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.Element buttonCreate({bool ripple: true, bool raised, String tag : 'button'}) {
  List<String> classes = [mdl.button, mdl.jsButton];
  if (ripple == true) {
    classes.add(mdl.jsRippleEffect);
  }
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }

  html.Element button = new html.Element.tag(tag)
    ..classes.addAll(classes);
  return button;
}

buttonUpgrade(html.Element button) {
  mdl.componentHandler.upgradeElement(button);
}
