@Deprecated('Do no use')
library;

import 'dart:async';
import 'dart:js' as js;

import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:tekartik_browser_utils/js_utils.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:tekartik_common_utils/env_utils.dart';

// Load jquery and bootstrap
Future loadMdl() async {
  await Future.wait([
    () async {
      await loadMdlCss();
      await loadMaterialIconsCss();
    }(),
    () async {
      await loadMdlJs();
    }(),
  ]);
}

//<script defer src='https://code.getmdl.io/1.2.0/material.min.js'></script>
/// As of 2026-02-15: Exception: script https://code.getmdl.io/1.3.0/material.min.js not loaded
@Deprecated('Load packaged js and css instead of cdn')
Future loadCdnMdlJs({Version? version}) async {
  return await loadMdlJs();
}

Future loadMdlJs() async {
  // already loaded?
  if (js.context['componentHandler'] != null) {
    return null;
  }

  // load mdl js
  await loadJavascriptScript('packages/tekartik_mdl_js/js/material.min.js');
  return null;
}

Future loadMdlCss() async {
  await loadStylesheet('packages/tekartik_mdl_js/css/material.min.css');
}

// <link rel='stylesheet' href='https://code.getmdl.io/1.2.0/material.indigo-pink.min.css'>
@Deprecated('Load packaged js and css instead of cdn')
Future loadCdnMdlCss({Version? version, String theme = 'indigo-pink'}) async {
  await loadMdlCss();
}

@Deprecated('Load packaged js and css instead of cdn')
Future loadCdnMaterialIconsCss() async {
  await loadMaterialIconsCss();
}

Future loadMaterialIconsCss() async {
  await loadStylesheet(
    'packages/tekartik_mdl_js/font/material-design-icons/material-icons.css',
  );
}
