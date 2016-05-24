library tekartik.mdl_js.loader;

import 'package:tekartik_browser_utils/js_utils.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'dart:async';
import 'dart:js' as js;

Future loadMdlJs() async {
  // already loaded?
  if (js.context['componentHandler'] != null) {
    return null;
  }

  // load mdl js
  await loadJavascriptScript("packages/tekartik_mdl_js/js/material.min.js");
  return null;
}

Future loadMdlCss() async {
  await loadStylesheet("packages/tekartik_mdl_js/css/material.min.css");
}

Future loadCdnMaterialIconsCss() async {
  await loadStylesheet("//fonts.googleapis.com/icon?family=Material+Icons");
}

Future loadMaterialIconsCss() async {
  await loadStylesheet(
      "packages/tekartik_mdl_js/font/material-design-icons/material-icons.css");
}
