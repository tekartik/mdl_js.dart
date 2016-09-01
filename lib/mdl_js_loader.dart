library tekartik.mdl_js.loader;

import 'package:tekartik_browser_utils/js_utils.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'dart:async';
import 'dart:js' as js;
import 'mdl_version.dart';

//<script defer src="https://code.getmdl.io/1.2.0/material.min.js"></script>
Future loadCdnMdlJs() async {
  // already loaded?
  if (js.context['componentHandler'] != null) {
    return null;
  }

  // load mdl js
  await loadJavascriptScript("https://code.getmdl.io/${version}/material.min.js");
  return null;
}

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

// <link rel="stylesheet" href="https://code.getmdl.io/1.2.0/material.indigo-pink.min.css">

Future loadCdnMdlCss({String theme: "indigo-pink"}) async {
  await loadStylesheet("https://code.getmdl.io/${version}/material.${theme}.min.css");
}

Future loadCdnMaterialIconsCss() async {
  await loadStylesheet("//fonts.googleapis.com/icon?family=Material+Icons");
}

Future loadMaterialIconsCss() async {
  await loadStylesheet(
      "packages/tekartik_mdl_js/font/material-design-icons/material-icons.css");
}
