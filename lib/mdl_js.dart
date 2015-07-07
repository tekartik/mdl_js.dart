library tekartik.mdl_js;

import 'dart:html' as html;
import 'dart:js' as js;

final String materialTextfieldType = 'MaterialTextfield';
final String materialButtonType = 'MaterialButton';

class ComponentHandler {
  js.JsObject _jsComponentHandler = js.context['componentHandler'];

  ComponentHandler() {
    if (_jsComponentHandler == null) {
      throw "componentHandler not defined, make sure material.js is loaded";
    }
  }

  /// Upgrade a specific element
  void upgradeElement(html.HtmlElement element, { String jsClass }) {
    _jsComponentHandler.callMethod('upgradeElement', [element, jsClass]);
  }
}

ComponentHandler _componentHandler;
ComponentHandler get componentHandler {
  if (_componentHandler == null) {
    _componentHandler = new ComponentHandler();
  }
  return _componentHandler;
}
