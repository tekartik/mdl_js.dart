library tekartik.mdj_js.textfield;

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'dart:html' as html;
import 'dart:html';
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;
import 'dart:js' as js;
import 'dart:async';

void textfieldChange(html.Element textfield, String value) {
  value ??= "";
  js.JsObject textField =
      new js.JsObject.fromBrowserObject(textfield)['MaterialTextfield'];
  textField.callMethod('change', [value]);
}

textfieldUpgrade(html.Element textfield) {
  mdl.componentHandler
      .upgradeElement(textfield, jsClass: materialTextfieldType);
}

// <div class="mdl-textfield mdl-js-textfield textfield-demo is-upgraded is-dirty"
// data-upgraded=",MaterialTextfield"><input class="mdl-textfield__input" type="text" pattern="[0-9]*" id="sample2"><label class="mdl-textfield__label" for="sample2">Number...</label><span class="mdl-textfield__error">Input is not a number!</span></div>

// <form action="#"><div class="mdl-textfield mdl-js-textfield textfield-demo">
// <input class="mdl-textfield__input" type="text" pattern="[0-9]*" id="sample2">
// <label class="mdl-textfield__label" for="sample2">Number...</label>
// <span class="mdl-textfield__error">Input is not a number!</span></div></form>
class TextField {
  html.Element _textFieldElement; // a div
  InputElement _inputElement;

  Element get element => _textFieldElement;
  html.LabelElement _labelElement;

  TextField(
      {String id,
      String value,
      bool numeric,
      String label,
      String inputId,
      String errorLabel,
      bool floatingLabel: true}) {
    //var form = document.createElement("form");
    //form.setAttribute("action", "#");
    var div = document.createElement("div")..id = id;
    _textFieldElement = div;

    div.className = "mdl-textfield mdl-js-textfield textfield-demo";
    InputElement input = document.createElement("input");
    input.className = "mdl-textfield__input";
    input.setAttribute("type", "text");
    //input.setAttribute("pattern", "[0-9]*");

    input.id = "${inputId}_input";
    _inputElement = input;
    if (value != null) {
      input.value = value;
    }
    if (numeric == true) {
      this.pattern = "[0-9]*";
    }
    _labelElement = document.createElement("label") as html.LabelElement;
    _labelElement.className = "mdl-textfield__label";
    _labelElement.setAttribute("for", input.id);
    _labelElement.text = label;
    var span = document.createElement("span");
    span.className = "mdl-textfield__error";
    if (errorLabel != null) {
      span.text = errorLabel;
    }
    div.append(input);
    div.append(_labelElement);
    div.append(span);

    if (floatingLabel == true) {
      _textFieldElement.classes.add("mdl-textfield--floating-label");
    }
    componentHandler.upgradeElement(div); //, materialTextfieldType);

    if (value != null) {
      this.value = value;
    }
  }

  Stream<Event> get onChange => _inputElement.onChange;

  void focus() => _inputElement.focus();

  set pattern(String pattern) {
    _inputElement.pattern = pattern;
  }

  set value(String value) {
    textfieldChange(_textFieldElement, value);
  }

  set label(String label) {
    _labelElement.text = label;
  }

  String get value => _inputElement.value;
}
