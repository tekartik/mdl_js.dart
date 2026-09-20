---
name: tekartik-mdl-js-widgets
description: >-
  Use when building Material Design Lite DOM from Dart with tekartik_mdl_js:
  buttonCreate / buttonUpgrade / buttonSetActive, layoutCreate,
  layoutDrawerCreate / layoutDrawerToggle, layoutHeaderCreate,
  layoutTitleCreate, navigationCreate, layoutContentCreate, gridCreate /
  cellCreate, listCreate / listItemCreate / listItemAvatarCreate, newIcon,
  the TextField class with textfieldUpgrade / textfieldChange, and the
  mdl-* class name constants of mdl_classes.dart. Legacy dart:html only.
---

# MDL element builders (tekartik_mdl_js)

`tekartik_mdl_js` ships thin `dart:html` builders that create Material Design
Lite 1.3 markup (the right `mdl-*` classes) and upgrade it through MDL's
`componentHandler`. MDL is **retired upstream** and every library is annotated
`@Deprecated('Do no use')`: this is for maintaining existing `dart:html` apps
only. Loading the css/js bundle and the upgrade mechanics are covered by the
sibling skill [tekartik-mdl-js-setup](../tekartik-mdl-js-setup/SKILL.md);
nothing below works before `await loadMdl()`.

## Guidelines

* Import only what you need, or `package:tekartik_mdl_js/mdl_import.dart` for
  everything (loader, handler, classes and builders). Expect
  `deprecated_member_use` warnings.
* The builders only create detached elements with the right classes: you still
  append them to the document and, for the js-backed components, upgrade them.
  Append first, upgrade after, otherwise MDL misses the parent.
* Buttons (`mdl_button.dart`):
  `buttonCreate({bool ripple = true, bool? raised, bool? colored, String tag = 'button'})`
  returns an `Element` with `mdl-button mdl-js-button` (+ `mdl-js-ripple-effect`,
  `mdl-button--raised`, `mdl-button--colored`); `buttonUpgrade(button)` upgrades
  it; `buttonSetActive(button, bool)` toggles the `is-active` class. Set the
  label yourself (`..text = 'Send'`), the builder does not.
* Layout (`mdl_layout.dart`), all `dart:html` elements to nest by hand:
  `layoutCreate({fixedDrawer, overlayDrawerButton, fixedHeader})` (note: the
  `mdl-layout--overlay-drawer-button` class is always added),
  `layoutHeaderCreate({transparent})`, `layoutHeaderRowCreate()`,
  `layoutTitleCreate({title})` (the title is set as `innerHtml`),
  `layoutSpacerCreate()`, `layoutDrawerCreate()`, `navigationCreate()`,
  `navigationLinkCreate()`, `layoutContentCreate()`; then `layoutUpgrade(layout)`.
  Show/hide the drawer with `layoutDrawerShow/Hide/Toggle(drawer)`, which just
  toggle `is-visible`.
* Grid (`mdl_grid.dart`): `gridCreate()` then
  `cellCreate(column, {tablet, phone})` - the column counts are the MDL
  `mdl-cell--<n>-col`, `-tablet`, `-phone` modifiers (12 columns desktop,
  8 tablet, 4 phone). No upgrade needed, the grid is css only.
* Lists (`mdl_list.dart`): `listCreate()` (a `<ul>`),
  `listItemCreate({threeLine})` (a `<li>`), then the content wrappers
  `listItemPrimaryContentCreate()`, `listItemTextBodyCreate()`,
  `listItemSecondaryContentCreate()`, `listItemSecondaryActionCreate()` and
  `listItemAvatarCreate({tag, icon})` (defaults to the `person` icon). Each
  takes an optional `tag:`. Css only as well.
* Icons (`mdl_icons.dart`): `newIcon('star')` builds `<i class="material-icons">
  star</i>`; constants `materialIcons` and `iconPerson`. The icon font comes
  from `loadMaterialIconsCss()`.
* Text fields (`mdl_textfield.dart`):
  * `TextField({id, inputId, label, value, numeric, errorLabel, floatingLabel})`
    builds the whole `mdl-textfield` div (input + label + error span) **and
    upgrades it in the constructor**, so the js bundle must already be loaded.
    Use `element` (nullable) to append it, `value` to read/write, `label`,
    `pattern`, `focus()` and `onChange`.
  * Always pass `inputId`: the input id is built as `'${inputId}_input'` and
    becomes `null_input` otherwise, which collides between instances.
  * `numeric: true` sets the `[0-9]*` pattern, `errorLabel` fills the
    `mdl-textfield__error` span, `floatingLabel` (default `true`) adds
    `mdl-textfield--floating-label`.
  * Setting `value` goes through the js component (`textfieldChange`) so the
    floating label and dirty state follow; writing `input.value` directly does
    not.
  * For hand written markup use `textfieldUpgrade(element)` (upgrades with
    `materialTextfieldType`) and `textfieldChange(element, value)`.
* `mdl_classes.dart` holds the class name constants used by the builders and is
  the right place to get a class name for markup written by hand: `button`,
  `jsButton`, `buttonRaised`, `buttonColored`, `jsRippleEffect`, `textfield`,
  `progress`, `spinner`, `slider`/`jsSlider`, `grid`, `cell`, `cellCol(n)`,
  `cellColTablet(n)`, `cellColPhone(n)`, `layout`, `jsLayout`,
  `layoutFixedDrawer`, `layoutFixedHeader`, `layoutDrawer`, `layoutHeader`,
  `layoutHeaderRow`, `layoutHeaderTransparent`, `layoutContent`, `layoutTitle`,
  `layoutSpacer`, `layoutLargeScreenOnly`, `navigation`, `navigationLink`,
  `list`, `listItem`, `listItemThreeLine`, `listItemPrimaryContent`,
  `listItemSecondaryContent`, `listItemSecondaryAction`, `listItemTextBody`,
  `listItemAvatar`, `isUpgraded`, `isVisible`, `isActive`, plus the
  `prefixed()` / `jsPrefixed()` helpers. It is the only library of the package
  that is not deprecated.
* Components MDL provides but this package has no builder for (progress,
  spinner, slider, toolbar, ...) are plain markup upgraded with
  `componentHandler!.upgradeElement(element)`.

## Examples

### Raised button

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_button.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';

Future<void> main() async {
  await loadMdl();

  var button = buttonCreate(raised: true, colored: true)..text = 'Send';
  document.body!.append(button);
  buttonUpgrade(button);

  button.onClick.listen((_) => buttonSetActive(button, true));
}
```

### Layout with a drawer and a header

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_layout.dart';

Future<void> main() async {
  await loadMdl();

  var header = layoutHeaderCreate()
    ..append(
      layoutHeaderRowCreate()
        ..append(layoutTitleCreate(title: 'My app'))
        ..append(layoutSpacerCreate()),
    );
  var drawer = layoutDrawerCreate()
    ..append(layoutTitleCreate(title: 'Menu'))
    ..append(
      navigationCreate()
        ..append(
          navigationLinkCreate()
            ..href = '#home'
            ..text = 'Home',
        ),
    );
  var content = layoutContentCreate();

  var layout = layoutCreate(fixedDrawer: true, fixedHeader: true)
    ..append(header)
    ..append(drawer)
    ..append(content);
  document.body!.append(layout);
  layoutUpgrade(layout);

  // Manual toggle (just the is-visible class).
  layoutDrawerToggle(drawer);
}
```

### Responsive grid

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_classes.dart' as mdl;
import 'package:tekartik_mdl_js/mdl_grid.dart';

void buildGrid() {
  var grid = gridCreate();
  for (var i = 0; i < 3; i++) {
    // 4 of 12 columns on desktop, 8 on tablet, 4 on phone.
    grid.append(cellCreate(4, tablet: 8, phone: 4)..text = 'cell $i');
  }
  print(mdl.cellCol(4)); // mdl-cell--4-col
  document.querySelector('#container')!.append(grid);
}
```

### Three line list with avatar and action

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_icons.dart';
import 'package:tekartik_mdl_js/mdl_list.dart';

Element buildContactList() {
  var list = listCreate();

  var primary = listItemPrimaryContentCreate()
    ..append(listItemAvatarCreate()) // person icon
    ..append(SpanElement()..appendText('Bob Odenkirk'))
    ..append(listItemTextBodyCreate()..appendText('Better call Saul'));
  var secondary = listItemSecondaryContentCreate()
    ..append(listItemSecondaryActionCreate()..append(newIcon('star')));

  return list
    ..append(
      listItemCreate(threeLine: true)
        ..append(primary)
        ..append(secondary),
    );
}
```

### Text field

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';

Future<void> main() async {
  // The constructor upgrades the element, so load the js bundle first.
  await loadMdl();

  var field = TextField(
    inputId: 'amount',
    label: 'Amount',
    value: '10',
    numeric: true,
    errorLabel: 'Input is not a number!',
  );
  document.querySelector('#container')!.append(field.element!);

  field.onChange.listen((_) => print('new value ${field.value}'));
  field.value = '42'; // keeps the floating label in sync
  field.label = 'Amount (EUR)';
  field.focus();
}
```

### Upgrading hand written textfield markup

```dart
// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';

Future<void> main() async {
  await loadMdl();

  var div = DivElement()..className = 'mdl-textfield mdl-js-textfield';
  div.append(
    InputElement()
      ..className = 'mdl-textfield__input'
      ..type = 'text',
  );
  document.body!.append(div);

  textfieldUpgrade(div);
  textfieldChange(div, 'some value');
}
```
