/// MDL layout: layout, drawer, header, title, navigation, content.
@Deprecated('Do no use')
library;

import 'package:web/web.dart' as web;

import 'mdl_classes.dart' as mdl;
import 'mdl_js.dart' as mdl;
import 'src/dom_prv.dart';

/// A new layout `div` (`mdl-layout mdl-js-layout` and the options).
web.HTMLDivElement layoutCreate({
  bool? fixedDrawer,
  bool? overlayDrawerButton,
  bool? fixedHeader,
}) {
  /*
  <div class='mdl-layout mdl-js-layout mdl-layout--fixed-drawer
            mdl-layout--overlay-drawer-button'>
   */
  final classes = [mdl.layout, mdl.jsLayout];
  if (fixedDrawer == true) {
    classes.add(mdl.layoutFixedDrawer);
  }
  if (fixedHeader == true) {
    classes.add(mdl.layoutFixedHeader);
  }
  if (overlayDrawerButton == true) {
    classes.add(mdl.layoutOverlayDrawerButton);
  }
  final div = web.HTMLDivElement();
  addClasses(div, classes);
  return div;
}

/// Upgrades [layout].
void layoutUpgrade(web.HTMLDivElement layout) {
  mdl.componentHandler!.upgradeElement(layout);
}

/*
<div class='mdl-layout__drawer'>
        <span class='mdl-layout-title'>Title</span>
        <nav class='mdl-navigation'>
            <a class='mdl-navigation__link' href=''>Link</a>
        </nav>
    </div>
 */

/// A new drawer.
web.HTMLDivElement layoutDrawerCreate() {
  return web.HTMLDivElement()..classList.add(mdl.layoutDrawer);
}

/// Shows the drawer.
void layoutDrawerShow(web.HTMLDivElement layoutDrawer) {
  layoutDrawer.classList.add(mdl.isVisible);
}

/// Hides the drawer.
void layoutDrawerHide(web.HTMLDivElement layoutDrawer) {
  layoutDrawer.classList.remove(mdl.isVisible);
}

/// Shows or hides the drawer.
void layoutDrawerToggle(web.HTMLDivElement layoutDrawer) {
  layoutDrawer.classList.toggle(mdl.isVisible);
}

/// A new header.
web.Element layoutHeaderCreate({bool? transparent}) {
  final classes = [mdl.layoutHeader];
  if (transparent == true) {
    classes.add(mdl.layoutHeaderTransparent);
  }
  return createElementWithClasses('header', classes);
}

/// A new header row.
web.HTMLDivElement layoutHeaderRowCreate() {
  return web.HTMLDivElement()..classList.add(mdl.layoutHeaderRow);
}

/// A new title, [title] as its text (not parsed as HTML).
web.HTMLSpanElement layoutTitleCreate({String? title}) {
  final span = web.HTMLSpanElement()..classList.add(mdl.layoutTitle);
  if (title != null) {
    span.textContent = title;
  }
  return span;
}

/// A new spacer.
web.HTMLDivElement layoutSpacerCreate() {
  return web.HTMLDivElement()..classList.add(mdl.layoutSpacer);
}

/*
<nav class='mdl-navigation'>
<a class='mdl-navigation__link' href=''>Link</a>
</nav>
*/
/// A new navigation.
web.Element navigationCreate() {
  return createElementWithClasses('nav', [mdl.navigation]);
}

/// A new navigation link.
web.HTMLAnchorElement navigationLinkCreate() {
  return web.HTMLAnchorElement()..classList.add(mdl.navigationLink);
}

/*
<main class='mdl-layout__content'>
<div class='page-content'><!-- Your content goes here --></div>
</main>
*/
/// A new content (`main`).
web.Element layoutContentCreate() {
  return createElementWithClasses('main', [mdl.layoutContent]);
}
