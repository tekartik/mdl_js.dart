/// MDL button.
@Deprecated('Do no use')
library;

import 'package:web/web.dart' as web;

import 'mdl_classes.dart' as mdl;
import 'mdl_js.dart' as mdl;
import 'src/dom_prv.dart';

/// A new [tag] MDL button, to upgrade ([buttonUpgrade]) once in the page.
web.Element buttonCreate({
  bool ripple = true,
  bool? raised,
  bool? colored,
  String tag = 'button',
}) {
  final classes = [mdl.button, mdl.jsButton];
  if (ripple) {
    classes.add(mdl.jsRippleEffect);
  }
  if (raised == true) {
    classes.add(mdl.buttonRaised);
  }
  if (colored == true) {
    classes.add(mdl.buttonColored);
  }

  return createElementWithClasses(tag, classes);
}

/// Upgrades [button] (`componentHandler.upgradeElement`).
void buttonUpgrade(web.Element button) {
  mdl.componentHandler!.upgradeElement(button);
}

/// Adds or removes the active class.
void buttonSetActive(web.Element button, bool active) {
  if (active) {
    button.classList.add(mdl.isActive);
  } else {
    button.classList.remove(mdl.isActive);
  }
}
