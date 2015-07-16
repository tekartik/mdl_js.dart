library tekartik.mdl_js;

import 'dart:html' as html;
import 'dart:js' as js;
import "mdl_classes.dart" as mdl;
import "mdl_component.dart" as mdl;

final String materialTextfieldType = 'MaterialTextfield';
final String materialButtonType = 'MaterialButton';
final String materialRippleType = 'MaterialRipple';
final String materialProgressType = 'MaterialProgress';
final String materialSpinnerType = 'MaterialSpinner';
final String materialSliderType = 'MaterialSlider';
final String materialLayoutType = 'MaterialLayout';

class ComponentHandler {
  js.JsObject _jsComponentHandler = js.context['componentHandler'];

  ComponentHandler() {
    if (_jsComponentHandler == null) {
      throw "componentHandler not defined, make sure material.js is loaded";
    }
  }

  /*
  Future upgrade(html.HtmlElement element) async {
    Stream stream = mdl.onComponentUpgraded(element);
    print(element.classes);
    print(element.dataset['upgraded']);
    //stream.listen((e) => print('upgraded'));
    int eventCount = upgradeElement(element);
    print(eventCount);
    if (eventCount > 1) {
      //stream.skip(eventCount - 1);
    } else if (eventCount == 0) {
      return;
    }
    print(element.dataset['upgraded']);
    await stream.first;
    //return new Future.value();
  }
  */

  /// Upgrade a specific element
  /// return the number of upgrades performed
  int upgradeElement(html.HtmlElement element, { String jsClass }) {
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
      if (classes.contains(mdl.slider)) {
        jsClasses.add(materialSliderType);
      }
      if (classes.contains(mdl.layout)) {
        jsClasses.add(materialLayoutType);
      }
      if (classes.contains(mdl.jsRippleEffect)) {
        jsClasses.add(materialRippleType);
      }
      if (jsClasses.isEmpty) {
        throw "element type cannot be found";
      } else {
        int count = 0;
        for (jsClass in jsClasses) {
          count += upgradeElement(element, jsClass: jsClass);
        }
        return count;
      }
    } else {
      String upgraded = element.dataset['upgraded'];
      if (upgraded != null) {
        if (upgraded.split(",").contains(jsClass)) {
          return 0;
        }
      }
      _jsComponentHandler.callMethod('upgradeElement', [element, jsClass]);
      return 1;
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
