/// The MDL `componentHandler` (upgrade the elements added after the page
/// load), on dart:js_interop.
@Deprecated('Do no use')
library;

import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'src/import.dart' as mdl;

/// MDL component types, the `jsClass` of [ComponentHandler.upgradeElement].
final String materialTextfieldType = 'MaterialTextfield';

/// Button.
final String materialButtonType = 'MaterialButton';

/// Ripple.
final String materialRippleType = 'MaterialRipple';

/// Progress.
final String materialProgressType = 'MaterialProgress';

/// Spinner.
final String materialSpinnerType = 'MaterialSpinner';

/// Slider.
final String materialSliderType = 'MaterialSlider';

/// Layout.
final String materialLayoutType = 'MaterialLayout';

/// The MDL `componentHandler` of the page, read on each call: a handler
/// created before `loadMdlJs()` works once the script is loaded.
class ComponentHandler {
  /// Throws a [StateError] when material.js is not loaded.
  JsComponentHandler get _jsComponentHandler {
    var handler = jsComponentHandler;
    if (handler == null) {
      throw StateError('MDL componentHandler not loaded (loadMdlJs)');
    }
    return handler;
  }

  /// The handler.
  ComponentHandler();

  /// Upgrades [element] (every MDL class it has), throws a [StateError]
  /// when nothing was upgraded.
  Future upgrade(web.HTMLElement element) {
    upgradeElement(element);
    if (!mdl.isComponentUpgraded(element)) {
      throw StateError(
        'element not upgrade $element ${element.getAttribute('class')}',
      );
    }
    return Future.value();
  }

  /// Upgrades [element]: every MDL class it has, or only [jsClass]
  /// ([materialButtonType]...).
  void upgradeElement(web.Element element, {String? jsClass}) {
    if (jsClass == null) {
      _jsComponentHandler.upgradeElement(element);
    } else {
      _jsComponentHandler.upgradeElement(element, jsClass);
    }
  }
}

ComponentHandler? _componentHandler;

/// The component handler.
ComponentHandler? get componentHandler {
  _componentHandler ??= ComponentHandler();
  return _componentHandler;
}

/// The JS `componentHandler` of material.js.
extension type JsComponentHandler._(JSObject _) implements JSObject {
  /// Upgrades every MDL element of the page.
  external JSAny? upgradeDom();

  /// Upgrades [element], or only its [jsClass] component.
  external JSAny? upgradeElement(web.Element element, [String jsClass]);
}

/// The JS `componentHandler`, null until material.js is loaded.
@JS('componentHandler')
external JsComponentHandler? get jsComponentHandler;
