# tekartik_mdl_js

The [Material Design Lite](https://getmdl.io) 1.3.0 css, js and material
icons font, packaged for Dart web apps, with loaders and small
`package:web` builders (button, layout, list, grid, text field) upgraded
through MDL's `componentHandler`.

**Deprecated.** MDL is archived upstream and every library here except
`mdl_classes.dart` and `mdl_version.dart` is marked `@Deprecated`. The
package is built on `dart:js_interop` and `package:web`: browser only,
compiled with dart2js or dart2wasm (`build_web_compilers`, `dart compile
js` / `wasm`), never on the Dart VM. Keep it for existing pages; do not
start a new app on it.

## Getting started

Git dependency (not on pub.dev, the package is at the repository root):

```yaml
dependencies:
  tekartik_mdl_js:
    git:
      url: https://github.com/tekartik/mdl_js.dart
```

```dart
// ignore_for_file: deprecated_member_use
import 'package:tekartik_mdl_js/mdl_button.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  // Adds the css, the material icons css and the js of the package
  // (packages/tekartik_mdl_js/...), each once: no tag needed in index.html.
  await loadMdl();

  var button = buttonCreate(raised: true, colored: true)
    ..textContent = 'Send';
  web.document.body!.append(button);
  // Append first, then upgrade (MDL adds its js behaviour, the ripple).
  buttonUpgrade(button);
}
```

## What it holds

- `mdl_js_loader.dart`: `loadMdl()` (both stylesheets and the js),
  `loadMdlJs()`, `loadMdlCss()`, `loadMaterialIconsCss()`: each file is
  added once, concurrent calls included. The `loadCdn*` functions are
  deprecated shims loading the packaged files.
- `mdl_js.dart`: `componentHandler!.upgradeElement(element, {jsClass})`,
  `jsComponentHandler!.upgradeDom()` (null until the js is loaded), the js
  class names (`materialButtonType`, `materialTextfieldType`...).
- `mdl_component.dart`: `isComponentUpgraded`, `onComponentUpgraded`,
  `whenComponentUpgraded`.
- Builders: `mdl_button.dart`, `mdl_layout.dart`, `mdl_list.dart`,
  `mdl_grid.dart`, `mdl_icons.dart`, `mdl_textfield.dart` (`TextField`);
  `mdl_classes.dart` holds the `mdl-*` class names; `mdl_import.dart`
  exports everything.

## Pitfalls

- Await a loader before upgrading: `componentHandler` throws a
  `StateError` while MDL's js is not loaded (it works once loaded, even
  when read before).
- The asset urls are relative (`packages/tekartik_mdl_js/...`): serve the
  page from the root of the build.
- `TextField(...)` upgrades its element in its constructor: load the js
  first.

## Migrating from 0.5.x (dart:html / package:js)

- Every builder takes and returns `package:web` elements (`web.Element`,
  `web.HTMLDivElement`, `web.HTMLSpanElement`, `web.HTMLAnchorElement`)
  instead of `dart:html` ones; `TextField.element` is a `web.Element?`,
  `TextField.onChange` a `Stream<web.Event>`, `onComponentUpgraded` a
  `Stream<web.Event>`.
- `JsComponentHandler` is an extension type and `jsComponentHandler` is
  nullable (it was null at runtime before the js was loaded):
  `jsComponentHandler!.upgradeDom()`.
- `layoutTitleCreate(title:)` sets the title as text (it was parsed as
  HTML).

## Example

`example/starter/` (a page loading MDL), `example/component-handler/`
(upgrade samples per component), `example/templates/` (MDL's own templates).
Tests: `dart test -p chrome` (`dart_test.yaml` declares vm and chrome, the
dart2js and dart2wasm compilers).
