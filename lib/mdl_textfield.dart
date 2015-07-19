library tekartik.mdj_js.textfield;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;
import 'dart:js' as js;

void textfieldChange(html.Element textfield, String value) {
  js.JsObject textField = new js.JsObject.fromBrowserObject(textfield)['MaterialTextfield'];
  textField.callMethod('change', [value]);
}

textfieldUpgrade(html.Element textfield) {
  mdl.componentHandler.upgradeElement(textfield);
}