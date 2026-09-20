---
name: tekartik-mdl-js-setup
description: >-
  Use when loading the bundled Material Design Lite 1.3 css/js in a legacy Dart
  web app with tekartik_mdl_js and upgrading elements: loadMdl, loadMdlJs,
  loadMdlCss, loadMaterialIconsCss from mdl_js_loader.dart, componentHandler /
  ComponentHandler.upgradeElement / jsComponentHandler.upgradeDom and the
  materialButtonType, materialTextfieldType, materialSliderType... js class
  names from mdl_js.dart, and isComponentUpgraded / onComponentUpgraded /
  whenComponentUpgraded from mdl_component.dart. MDL is retired; dart:html
  only, no wasm.
---

# Loading MDL and upgrading elements (tekartik_mdl_js)

`tekartik_mdl_js` packages the Material Design Lite 1.3.0 `material.min.js` /
`material.min.css` bundle plus the material icons font, and wraps MDL's
`componentHandler` so a Dart web app can upgrade elements it creates at
runtime. Material Design Lite is **retired upstream** and every library here is
annotated `@Deprecated('Do no use')`: keep it for existing `dart:html` apps, do
not start a new project on it. The DOM builders (buttons, layout, list, grid,
textfield) are covered by the sibling skill
[tekartik-mdl-js-widgets](../tekartik-mdl-js-widgets/SKILL.md).

## Guidelines

* Dependency (git, not published on pub.dev):
  ```yaml
  dependencies:
    tekartik_mdl_js:
      git:
        url: https://github.com/tekartik/mdl_js.dart
  ```
  It is a `dart:html` + `dart:js` package: JavaScript compilation only
  (dart2js/ddc), never dart2wasm, and nothing in it runs on the Dart VM.
* Expect `deprecated_member_use` warnings on every import; the package's own
  code silences them with
  `// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package`.
* The assets live in `lib/` and are served by `build_web_compilers`/`webdev` at
  `packages/tekartik_mdl_js/js/material.min.js`,
  `packages/tekartik_mdl_js/css/material.min.css` and
  `packages/tekartik_mdl_js/font/material-design-icons/material-icons.css`.
  The loaders inject exactly those urls, so no `<link>`/`<script>` tag is
  needed in `index.html`.
* `package:tekartik_mdl_js/mdl_js_loader.dart`:
  * `loadMdl()` - css + material icons css + js, in parallel. The normal
    startup call.
  * `loadMdlJs()` - js only; returns immediately when `componentHandler` is
    already on `window`, so it is safe to call repeatedly.
  * `loadMdlCss()`, `loadMaterialIconsCss()` - the two stylesheets.
  * `loadCdnMdlJs({version})`, `loadCdnMdlCss({version, theme})` and
    `loadCdnMaterialIconsCss()` are deprecated shims that now load the packaged
    files; the code.getmdl.io CDN no longer serves them. Do not use them, and
    do not pass `version`/`theme` expecting an effect.
* Always `await` a loader before touching `componentHandler`,
  `jsComponentHandler` or any widget helper: `ComponentHandler` captures the
  js `componentHandler` object when first built and the getter caches that
  instance, so an early call leaves a broken handler behind.
* `package:tekartik_mdl_js/mdl_js.dart` (import it for the handler):
  * `componentHandler` - a nullable `ComponentHandler?` (use `componentHandler!`
    as the package's own code does).
  * `ComponentHandler.upgradeElement(element, {String? jsClass})` - upgrades one
    element; without `jsClass` MDL picks the components from the element's
    `mdl-js-*` classes, with it only that one. Upgrading twice is a no-op.
  * `ComponentHandler.upgrade(HtmlElement element)` - upgrades and throws
    `StateError` if the element did not get upgraded; returns a already
    completed `Future`, it does not wait for the event.
  * `jsComponentHandler` - the raw js object; `jsComponentHandler.upgradeDom()`
    upgrades every `mdl-js-*` element currently in the document (use it after
    injecting a block of static markup).
  * js class names to pass as `jsClass`: `materialButtonType`,
    `materialTextfieldType`, `materialRippleType`, `materialProgressType`,
    `materialSpinnerType`, `materialSliderType`, `materialLayoutType`.
* An element is only upgraded if it carries the `mdl-js-*` class of the
  component (`mdl-js-button`, `mdl-js-textfield`, ...): `mdl-button` alone
  upgrades to nothing unless you pass `jsClass` explicitly. Ripples need
  `mdl-js-ripple-effect`, which is a second upgrade (`MaterialRipple`).
* `package:tekartik_mdl_js/mdl_component.dart` tracks upgrades:
  `isComponentUpgraded(element)` (reads `data-upgraded`),
  `onComponentUpgraded(element)` (the `mdl-componentupgraded` event stream, one
  event per js class) and `whenComponentUpgraded(element)` (a `Future`, already
  completed when the element is upgraded). Subscribe **before** calling
  `upgradeElement`: `data-upgraded` is set synchronously but the event fires
  after.
* `package:tekartik_mdl_js/mdl_version.dart` exposes `version` and
  `mdlVersionDefault` (both `1.3.0`), the version of the bundled
  `material.min.js`; the package test asserts the bundle matches.
* `package:tekartik_mdl_js/mdl_import.dart` re-exports every library at once
  (loader, handler, classes and widget builders) for app code that wants a
  single import.
* Tests are `@TestOn('browser')` and need the assets served, so run them
  through build_runner: `dart run build_runner test -- -p chrome`
  (`dart test -p chrome` works for tests that do not fetch
  `packages/tekartik_mdl_js/...`). `dart_test.yaml` declares `vm` and `chrome`.

## Examples

### App startup

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';

Future<void> main() async {
  // css + material icons css + js, in parallel.
  await loadMdl();
  document.body!.classes.add('app-ready');
}
```

### Upgrade an element created at runtime

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';

Future<void> main() async {
  await loadMdl();

  var button = document.createElement('button')
    ..className = 'mdl-button mdl-js-button mdl-js-ripple-effect'
    ..text = 'Click me';
  document.body!.append(button);

  // Listen first: the event fires after data-upgraded is set.
  var upgraded = whenComponentUpgraded(button);
  componentHandler!.upgradeElement(button);
  await upgraded;

  print(isComponentUpgraded(button)); // true
  print(button.attributes['data-upgraded']); // ,MaterialButton,MaterialRipple
}
```

### Upgrade static markup, or one precise component

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';

Future<void> main() async {
  await loadMdlJs();
  await loadMdlCss();

  // Whole document at once, after injecting a block of mdl markup.
  jsComponentHandler.upgradeDom();

  // Or one element, one js class.
  var slider = document.createElement('input') as InputElement
    ..className = 'mdl-slider mdl-js-slider'
    ..type = 'range';
  document.body!.append(slider);
  componentHandler!.upgradeElement(slider, jsClass: materialSliderType);
}
```

### Count upgrades of one element

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';

Future<void> main() async {
  await loadMdlJs();

  var button = document.createElement('button')
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

import 'dart:html';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';

void main() {
  setUp(() async {
    await loadMdlJs();
  });

  test('upgrade a button', () async {
    var button = document.createElement('button')
      ..className = 'mdl-button mdl-js-button';
    var upgraded = whenComponentUpgraded(button);
    componentHandler!.upgradeElement(button);
    expect(isComponentUpgraded(button), isTrue);
    expect(button.attributes['data-upgraded'], contains('MaterialButton'));
    await upgraded;
  });
}
```
