---
name: tekartik-mdl-js-setup
description: >-
  Use when loading the bundled Material Design Lite 1.3 css/js in a Dart web
  app with tekartik_mdl_js and upgrading elements: loadMdl, loadMdlJs,
  loadMdlCss, loadMaterialIconsCss from mdl_js_loader.dart, componentHandler /
  ComponentHandler.upgradeElement / jsComponentHandler.upgradeDom and the
  materialButtonType, materialTextfieldType, materialSliderType... js class
  names from mdl_js.dart, and isComponentUpgraded / onComponentUpgraded /
  whenComponentUpgraded from mdl_component.dart. MDL is retired upstream; the
  package is dart:js_interop + package:web (dart2js and dart2wasm).
---

# Loading MDL and upgrading elements (tekartik_mdl_js)

`tekartik_mdl_js` packages the Material Design Lite 1.3.0 `material.min.js` /
`material.min.css` bundle plus the material icons font, and wraps MDL's
`componentHandler` so a Dart web app can upgrade elements it creates at
runtime. Material Design Lite is **retired upstream** and every library here
but `mdl_classes.dart` and `mdl_version.dart` is annotated
`@Deprecated('Do no use')`: keep it for existing pages, do not start a new
project on it. The DOM builders (buttons, layout, list, grid, textfield) are
covered by the sibling skill
[tekartik-mdl-js-widgets](../tekartik-mdl-js-widgets/SKILL.md).

## Guidelines

* Dependency (git, not published on pub.dev):
  ```yaml
  dependencies:
    tekartik_mdl_js:
      git:
        url: https://github.com/tekartik/mdl_js.dart
  ```
  Built on `dart:js_interop` and `package:web` (since 0.6.0; `dart:html` and
  `package:js` before): browser only, dart2js or dart2wasm, nothing runs on
  the Dart VM. Elements are `package:web` types (`web.Element`,
  `web.HTMLDivElement`...).
* Expect `deprecated_member_use` infos on every import of a deprecated
  library; the package's own tests silence them with
  `// ignore_for_file: deprecated_member_use_from_same_package`.
* The assets live in `lib/` and are served by `build_web_compilers`/`webdev`
  (and by `dart test -p chrome`) at
  `packages/tekartik_mdl_js/js/material.min.js`,
  `packages/tekartik_mdl_js/css/material.min.css` and
  `packages/tekartik_mdl_js/font/material-design-icons/material-icons.css`.
  The loaders inject exactly those urls, so no `<link>`/`<script>` tag is
  needed in `index.html`.
* `package:tekartik_mdl_js/mdl_js_loader.dart`:
  * `loadMdl()` - the css then the material icons css, in parallel with the
    js. The normal startup call.
  * `loadMdlJs()` - js only; returns immediately when `componentHandler` is
    already on `window`.
  * `loadMdlCss()`, `loadMaterialIconsCss()` - the two stylesheets.
  * Every file is added once, whatever the number of calls, concurrent ones
    included (one pending load per url, since 0.6.0); a failed load is
    forgotten and the next call retries.
  * `loadCdnMdlJs({version})`, `loadCdnMdlCss({version, theme})` and
    `loadCdnMaterialIconsCss()` are deprecated shims that now load the packaged
    files; the code.getmdl.io CDN no longer serves them. Do not use them, and
    do not pass `version`/`theme` expecting an effect.
* `package:tekartik_mdl_js/mdl_js.dart` (import it for the handler):
  * `componentHandler` - a nullable `ComponentHandler?` (use `componentHandler!`
    as the package's own code does). It reads the js `componentHandler` on
    each call: one read before `loadMdlJs()` works once the script is loaded
    (it used to stay broken); a call while material.js is not loaded throws
    a `StateError`.
  * `ComponentHandler.upgradeElement(web.Element element, {String? jsClass})`
    - upgrades one element; without `jsClass` MDL picks the components from
    the element's `mdl-js-*` classes, with it only that one. Upgrading twice
    is a no-op.
  * `ComponentHandler.upgrade(web.HTMLElement element)` - upgrades and throws
    `StateError` if the element did not get upgraded; returns an already
    completed `Future`, it does not wait for the event.
  * `jsComponentHandler` - the raw js object (`JsComponentHandler?`, an
    extension type), null until material.js is loaded;
    `jsComponentHandler!.upgradeDom()` upgrades every `mdl-js-*` element
    currently in the document (use it after injecting a block of static
    markup).
  * js class names to pass as `jsClass`: `materialButtonType`,
    `materialTextfieldType`, `materialRippleType`, `materialProgressType`,
    `materialSpinnerType`, `materialSliderType`, `materialLayoutType`.
* An element is only upgraded if it carries the `mdl-js-*` class of the
  component (`mdl-js-button`, `mdl-js-textfield`, ...): `mdl-button` alone
  upgrades to nothing unless you pass `jsClass` explicitly. Ripples need
  `mdl-js-ripple-effect`, which is a second upgrade (`MaterialRipple`).
* `package:tekartik_mdl_js/mdl_component.dart` tracks upgrades:
  `isComponentUpgraded(element)` (reads `data-upgraded`),
  `onComponentUpgraded(element)` (a `Stream<web.Event>` of the
  `mdl-componentupgraded` events, one per js class) and
  `whenComponentUpgraded(element)` (a `Future`, already completed when the
  element is upgraded). Subscribe **before** calling `upgradeElement`:
  `data-upgraded` is set synchronously but the event fires after.
* `package:tekartik_mdl_js/mdl_version.dart` exposes `version` and
  `mdlVersionDefault` (both `1.3.0`), the version of the bundled
  `material.min.js`; the package test asserts the bundle matches.
* `package:tekartik_mdl_js/mdl_import.dart` re-exports every library at once
  (loader, handler, classes and widget builders) for app code that wants a
  single import.
* Tests are `@TestOn('browser')`: `dart test -p chrome` serves the package
  assets; `dart_test.yaml` declares `vm` and `chrome` and the `dart2js` and
  `dart2wasm` compilers.

## Examples

### App startup

```dart
// ignore_for_file: deprecated_member_use
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  // The stylesheets and the js, in parallel, each added once.
  await loadMdl();
  web.document.body!.classList.add('app-ready');
}
```

### Upgrade an element created at runtime

```dart
// ignore_for_file: deprecated_member_use
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  await loadMdl();

  var button = web.document.createElement('button')
    ..className = 'mdl-button mdl-js-button mdl-js-ripple-effect'
    ..textContent = 'Click me';
  web.document.body!.append(button);

  // Listen first: the event fires after data-upgraded is set.
  var upgraded = whenComponentUpgraded(button);
  componentHandler!.upgradeElement(button);
  await upgraded;

  print(isComponentUpgraded(button)); // true
  print(button.getAttribute('data-upgraded')); // ,MaterialButton,MaterialRipple
}
```

### Upgrade static markup, or one precise component

```dart
// ignore_for_file: deprecated_member_use
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  await loadMdlJs();
  await loadMdlCss();

  // Whole document at once, after injecting a block of mdl markup.
  jsComponentHandler!.upgradeDom();

  // Or one element, one js class.
  var slider = web.HTMLInputElement()
    ..className = 'mdl-slider mdl-js-slider'
    ..type = 'range';
  web.document.body!.append(slider);
  componentHandler!.upgradeElement(slider, jsClass: materialSliderType);
}
```

### Count upgrades of one element

```dart
// ignore_for_file: deprecated_member_use
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  await loadMdlJs();

  var button = web.document.createElement('button')
    ..className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
  onComponentUpgraded(button).listen((_) => print('upgraded'));

  // One event per js class, nothing on the second identical call.
  componentHandler!.upgradeElement(button, jsClass: materialButtonType);
  componentHandler!.upgradeElement(button, jsClass: materialButtonType);
  componentHandler!.upgradeElement(button, jsClass: materialRippleType);
}
```

### Browser test

```dart
// ignore_for_file: deprecated_member_use
@TestOn('browser')
library;

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  setUp(() async {
    await loadMdlJs();
  });

  test('upgrade a button', () async {
    var button = web.document.createElement('button')
      ..className = 'mdl-button mdl-js-button';
    var upgraded = whenComponentUpgraded(button);
    componentHandler!.upgradeElement(button);
    expect(isComponentUpgraded(button), isTrue);
    expect(button.getAttribute('data-upgraded'), contains('MaterialButton'));
    await upgraded;
  });
}
```
