library tekartik.mdj_js.layout;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.DivElement layoutCreate({bool fixedDrawer}) {
  /*
  <div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer
            mdl-layout--overlay-drawer-button">
   */
  List<String> classes = [mdl.layout, mdl.jsLayout, mdl.layoutOverlayDrawerButton];
  if (fixedDrawer == true) {
    classes.add(mdl.layoutFixedDrawer);
  }
  html.DivElement div = new html.DivElement()
  ..classes.addAll(classes);

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
  html.DivElement div = new html.DivElement()
    ..classes.add(mdl.layoutDrawer);
  return div;
}

html.SpanElement layoutTitleCreate({String title}) {
  html.SpanElement span = new html.SpanElement()
    ..classes.add(mdl.layoutTitle);
  if (title != null) {
    span.innerHtml = title;
  }
  return span;
}