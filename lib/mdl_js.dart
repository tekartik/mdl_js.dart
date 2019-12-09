// needed
@JS()
library tekartik.mdl_js;

import 'dart:async';
import 'dart:html' as html;

import 'package:js/js.dart';

import 'mdl_classes.dart' as mdl;
import 'mdl_component.dart' as mdl;
//import 'dart:js' as js;

final String materialTextfieldType = 'MaterialTextfield';
final String materialButtonType = 'MaterialButton';
final String materialRippleType = 'MaterialRipple';
final String materialProgressType = 'MaterialProgress';
final String materialSpinnerType = 'MaterialSpinner';
final String materialSliderType = 'MaterialSlider';
final String materialLayoutType = 'MaterialLayout';

class ComponentHandler {
  final _jsComponentHandler = jsComponentHandler;

  ComponentHandler() {
    if (_jsComponentHandler == null) {
      throw 'componentHandler not defined, make sure material.js is loaded';
    }
  }

  /* NOT WORKING */
  /*
  Future _upgrade(html.HtmlElement element) {
    upgradeElement(element);
    return mdl.whenComponentUpgraded(element);
  }
  */

  Future upgrade(html.HtmlElement element) {
    //stream.listen((e) => print('upgraded'));
    /*
    Completer completer = new Completer.sync();
    Stream stream = mdl.onComponentUpgraded(element);
    stream.listen((e) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    });
    */
    upgradeElement(element);
    if (!mdl.isComponentUpgraded(element)) {
      throw 'element not upgrade ${element} ${Map.from(element.attributes)}';
    }
    //return completer.future;
    return Future.value();
  }

  /// Upgrade a specific element
  /// return the number of upgrades performed
  void upgradeElement(html.Element element, {String jsClass}) {
    if (jsClass == null) {
      _jsComponentHandler.upgradeElement(element);
    } else {
      _jsComponentHandler.upgradeElement(element, jsClass);
    }
  }
// Handle when no jsClass is specified
/*
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
        throw 'element type cannot be found';
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
        if (upgraded.split(',').contains(jsClass)) {
          return 0;
        }
      }
      _jsComponentHandler.callMethod('upgradeElement', [element, jsClass]);
      return 1;
    }
  }
  */
}

ComponentHandler _componentHandler;

ComponentHandler get componentHandler {
  _componentHandler ??= ComponentHandler();
  return _componentHandler;
}

@JS()
@anonymous
class JsComponentHandler {
  external dynamic upgradeDom();

  external dynamic upgradeElement(html.Element element, [String jsClass]);
}

@JS('componentHandler')
external JsComponentHandler get jsComponentHandler;
