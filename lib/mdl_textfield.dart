/// MDL text field.
@Deprecated('Do no use')
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:web/web.dart' as web;

import 'src/import.dart' as mdl;

/// Sets the [value] of an upgraded MDL text field (`MaterialTextfield.change`).
void textfieldChange(web.Element textfield, String? value) {
  value ??= '';
  final textField = (textfield as JSObject)['MaterialTextfield'] as JSObject;
  textField.callMethod('change'.toJS, value.toJS);
}

/// Upgrades [textfield].
void textfieldUpgrade(web.Element textfield) {
  mdl.componentHandler!.upgradeElement(
    textfield,
    jsClass: materialTextfieldType,
  );
}

// <form action='#'><div class='mdl-textfield mdl-js-textfield textfield-demo'>
// <input class='mdl-textfield__input' type='text' pattern='[0-9]*' id='sample2'>
// <label class='mdl-textfield__label' for='sample2'>Number...</label>
// <span class='mdl-textfield__error'>Input is not a number!</span></div></form>
/// An MDL text field (a `div` with an input, a label and an error span),
/// upgraded on creation: material.js must be loaded.
class TextField {
  web.Element? _textFieldElement; // a div
  late web.HTMLInputElement _inputElement;

  /// The text field `div`.
  web.Element? get element => _textFieldElement;
  late web.HTMLLabelElement _labelElement;

  /// A text field: the `div` gets [id], the input `<inputId>_input` (and
  /// the label points to it) when [inputId] is given.
  TextField({
    String? id,
    String? value,
    bool? numeric,
    String? label,
    String? inputId,
    String? errorLabel,
    bool floatingLabel = true,
  }) {
    var div = web.HTMLDivElement();
    if (id != null) {
      div.id = id;
    }
    _textFieldElement = div;

    div.className = 'mdl-textfield mdl-js-textfield textfield-demo';
    final input = web.HTMLInputElement();
    input.className = 'mdl-textfield__input';
    input.setAttribute('type', 'text');

    if (inputId != null) {
      input.id = '${inputId}_input';
    }
    _inputElement = input;
    if (value != null) {
      input.value = value;
    }
    if (numeric == true) {
      pattern = '[0-9]*';
    }
    _labelElement = web.HTMLLabelElement();
    _labelElement.className = 'mdl-textfield__label';
    if (inputId != null) {
      _labelElement.setAttribute('for', input.id);
    }
    _labelElement.textContent = label;
    var span = web.HTMLSpanElement();
    span.className = 'mdl-textfield__error';
    if (errorLabel != null) {
      span.textContent = errorLabel;
    }
    div.append(input);
    div.append(_labelElement);
    div.append(span);

    if (floatingLabel) {
      div.classList.add('mdl-textfield--floating-label');
    }
    componentHandler!.upgradeElement(div);

    if (value != null) {
      this.value = value;
    }
  }

  /// The change events of the input.
  Stream<web.Event> get onChange =>
      web.EventStreamProviders.changeEvent.forTarget(_inputElement);

  /// Focuses the input.
  void focus() => _inputElement.focus();

  /// The input pattern.
  set pattern(String pattern) {
    _inputElement.pattern = pattern;
  }

  /// Sets the value (and the MDL state).
  set value(String? value) {
    textfieldChange(_textFieldElement!, value);
  }

  /// The label.
  set label(String label) {
    _labelElement.textContent = label;
  }

  /// The value.
  String? get value => _inputElement.value;
}
