library tekartik.mdl_js;

import 'dart:html' as html;
import 'dart:js' as js;

import "mdl_classes.dart" as mdl;

final String materialTextfieldType = 'MaterialTextfield';
final String materialButtonType = 'MaterialButton';
final String materialRippleType = 'MaterialRipple';
final String materialProgressType = 'MaterialProgress';
final String materialSpinnerType = 'MaterialSpinner';

class ComponentHandler {
  js.JsObject _jsComponentHandler = js.context['componentHandler'];

  ComponentHandler() {
    if (_jsComponentHandler == null) {
      throw "componentHandler not defined, make sure material.js is loaded";
    }
  }

  /// Upgrade a specific element
  void upgradeElement(html.HtmlElement element, { String jsClass }) {
    // Handle when no jsClass is specified
    if (jsClass == null) {
      List<String> jsClasses = [];
      html.CssClassSet classes = element.classes;
      if (classes.contains(mdl.button)) {
        jsClasses.add(materialButtonType);
      }
      if (classes.contains(mdl.textfield)) {
        jsClasses.add(materialTextfieldType);
      }
      if (classes.contains(mdl.progress)) {
        jsClasses.add(materialProgressType);
      }
      if (classes.contains(mdl.spinner)) {
        jsClasses.add(materialSpinnerType);
      }
      if (classes.contains(mdl.jsRippleEffect)) {
        jsClasses.add(materialRippleType);
      }
      if (jsClasses.isEmpty) {
        throw "element type cannot be found";
      } else {
        for (jsClass in jsClasses) {
          _jsComponentHandler.callMethod('upgradeElement', [element, jsClass]);
        }
      }
    } else {
      _jsComponentHandler.callMethod('upgradeElement', [element, jsClass]);
    }
  }
}

ComponentHandler _componentHandler;
ComponentHandler get componentHandler {
  if (_componentHandler == null) {
    _componentHandler = new ComponentHandler();
  }
  return _componentHandler;
}
