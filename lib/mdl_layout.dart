library tekartik.mdj_js.layout;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.DivElement layoutCreate(
    {bool fixedDrawer, bool overlayDrawerButton, bool fixedHeader}) {
  /*
  <div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer
            mdl-layout--overlay-drawer-button">
   */
  List<String> classes = [
    mdl.layout,
    mdl.jsLayout,
    mdl.layoutOverlayDrawerButton
  ];
  if (fixedDrawer == true) {
    classes.add(mdl.layoutFixedDrawer);
  }
  if (fixedHeader == true) {
    classes.add(mdl.layoutFixedHeader);
  }
  if (overlayDrawerButton == true) {
    classes.add(mdl.layoutOverlayDrawerButton);
  }
  html.DivElement div = new html.DivElement()..classes.addAll(classes);

  return div;
}

layoutUpgrade(html.DivElement layout) {
  mdl.componentHandler.upgradeElement(layout);
}

/*
<div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Title</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="">Link</a>
            <a class="mdl-navigation__link" href="">Link</a>
            <a class="mdl-navigation__link" href="">Link</a>
            <a class="mdl-navigation__link" href="">Link</a>
        </nav>
    </div>
 */

html.DivElement layoutDrawerCreate() {
  html.DivElement div = new html.DivElement()..classes.add(mdl.layoutDrawer);
  return div;
}

layoutDrawerShow(html.DivElement layoutDrawer) {
  layoutDrawer.classes.add(mdl.isVisible);
}

layoutDrawerHide(html.DivElement layoutDrawer) {
  layoutDrawer.classes.remove(mdl.isVisible);
}

layoutDrawerToggle(html.DivElement layoutDrawer) {
  layoutDrawer.classes.toggle(mdl.isVisible);
}

html.Element layoutHeaderCreate({bool transparent}) {
  List<String> classes = [mdl.layoutHeader];
  if (transparent == true) {
    classes.add(mdl.layoutHeaderTransparent);
  }
  html.Element header = new html.Element.tag("header")..classes.addAll(classes);
  return header;
}

html.DivElement layoutHeaderRowCreate() {
  List<String> classes = [mdl.layoutHeaderRow];
  html.DivElement row = new html.DivElement()..classes.addAll(classes);
  return row;
}

//
html.SpanElement layoutTitleCreate({String title}) {
  html.SpanElement span = new html.SpanElement()..classes.add(mdl.layoutTitle);
  if (title != null) {
    span.innerHtml = title;
  }
  return span;
}

//
html.DivElement layoutSpacerCreate() {
  html.DivElement div = new html.DivElement()..classes.add(mdl.layoutSpacer);
  return div;
}

/*
<nav class="mdl-navigation">
<a class="mdl-navigation__link" href="">Link</a>
<a class="mdl-navigation__link" href="">Link</a>
<a class="mdl-navigation__link" href="">Link</a>
<a class="mdl-navigation__link" href="">Link</a>
</nav>
*/
html.Element navigationCreate() {
  html.Element nav = new html.Element.tag("nav")..classes.add(mdl.navigation);
  return nav;
}

html.AnchorElement navigationLinkCreate() {
  html.AnchorElement nav = new html.AnchorElement()
    ..classes.add(mdl.navigationLink);
  return nav;
}

/*
<main class="mdl-layout__content">
<div class="page-content"><!-- Your content goes here --></div>
</main>
*/
html.Element layoutContentCreate() {
  List<String> classes = [mdl.layoutContent];
  html.Element header = new html.Element.tag("main")..classes.addAll(classes);
  return header;
}
