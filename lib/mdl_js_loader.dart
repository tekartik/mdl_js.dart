/// Loads the bundled Material Design Lite js and css.
@Deprecated('Do no use')
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:tekartik_browser_utils/js_utils.dart';

/// The loads started, by url: each file is added to the page once, a
/// failed load is forgotten (the next call retries).
final _loads = <String, Future<void>>{};

Future<void> _loadOnce(String url, Future<void> Function() load) {
  return _loads[url] ??= () async {
    try {
      await load();
    } catch (e, st) {
      unawaited(_loads.remove(url));
      Error.throwWithStackTrace(e, st);
    }
  }();
}

/// Loads the MDL css, then the material icons css, in parallel with the MDL
/// js, from the package assets (`packages/tekartik_mdl_js/...`). Each file
/// is added once, whatever the number of calls.
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

/// Loads the MDL js (`componentHandler`), unless already in the page.
Future loadMdlJs() async {
  // already loaded?
  if (globalContext['componentHandler'] != null) {
    return null;
  }

  // load mdl js
  const url = 'packages/tekartik_mdl_js/js/material.min.js';
  await _loadOnce(url, () async {
    await loadJavascriptScript(url);
  });
  return null;
}

/// Adds the MDL stylesheet, once.
Future loadMdlCss() async {
  const url = 'packages/tekartik_mdl_js/css/material.min.css';
  await _loadOnce(url, () => loadStylesheet(url));
}

// <link rel='stylesheet' href='https://code.getmdl.io/1.2.0/material.indigo-pink.min.css'>
@Deprecated('Load packaged js and css instead of cdn')
Future loadCdnMdlCss({Version? version, String theme = 'indigo-pink'}) async {
  await loadMdlCss();
}

/// Same as [loadMaterialIconsCss].
@Deprecated('Load packaged js and css instead of cdn')
Future loadCdnMaterialIconsCss() async {
  await loadMaterialIconsCss();
}

/// Adds the material icons stylesheet, once.
Future loadMaterialIconsCss() async {
  const url =
      'packages/tekartik_mdl_js/font/material-design-icons/material-icons.css';
  await _loadOnce(url, () => loadStylesheet(url));
}
