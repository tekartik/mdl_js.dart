library;

import 'dart:async';
import 'dart:js' as js;

import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:tekartik_browser_utils/js_utils.dart';
// ignore: depend_on_referenced_packages
import 'package:tekartik_common_utils/env_utils.dart';

import 'mdl_version.dart';

// Load jquery and bootstrap
Future loadMdl() async {
  if (isRelease) {
    await Future.wait([
      () async {
        await loadCdnMdlCss();
        await loadCdnMaterialIconsCss();
      }(),
      () async {
        await loadCdnMdlJs();
      }()
    ]);
  } else {
    await Future.wait([
      () async {
        await loadMdlCss();
        await loadMaterialIconsCss();
      }(),
      () async {
        await loadMdlJs();
      }()
    ]);
  }
}

//<script defer src='https://code.getmdl.io/1.2.0/material.min.js'></script>
Future loadCdnMdlJs({Version? version}) async {
  version ??= mdlVersionDefault;

  // already loaded?
  if (js.context['componentHandler'] != null) {
    return null;
  }

  // load mdl js
  await loadJavascriptScript('https://code.getmdl.io/$version/material.min.js');
  return null;
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

Future loadCdnMdlCss({Version? version, String theme = 'indigo-pink'}) async {
  version ??= mdlVersionDefault;
  await loadStylesheet(
      'https://code.getmdl.io/$version/material.$theme.min.css');
}

Future loadCdnMaterialIconsCss() async {
  await loadStylesheet('//fonts.googleapis.com/icon?family=Material+Icons');
}

Future loadMaterialIconsCss() async {
  await loadStylesheet(
      'packages/tekartik_mdl_js/font/material-design-icons/material-icons.css');
}
