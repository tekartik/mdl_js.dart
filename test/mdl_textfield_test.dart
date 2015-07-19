@TestOn("browser")
library tekartik.mdl_js.compoenent_handler_test;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:test/test.dart';
import 'dart:html';

void main() {

  group('textfield', () {
    setUp(() async {
      await(loadMdlJs());
    });


    DivElement _createTextfield() {
      DivElement textfield = new DivElement();
      textfield.className = 'mdl-textfield';
      InputElement input = new InputElement();
      input.className = "mdl-textfield__input";
      input.setAttribute("type", "text");
      textfield.append(input);
      return textfield;
    }
    test('upgrade', () async {
      DivElement textfield = _createTextfield();

      expect(isComponentUpgraded(textfield), false);
      expect(textfield.attributes['data-upgraded'], isNull);

      textfieldUpgrade(textfield);
      expect(isComponentUpgraded(textfield), true);
      expect(textfield.attributes['data-upgraded'], contains('MaterialTextfield'));
    });

    test('change', () async {
      DivElement textfield = _createTextfield();
      InputElement input = textfield.querySelector('input');
      textfieldUpgrade(textfield);
      expect(textfield.attributes['data-upgraded'], contains('MaterialTextfield'));
      expect(input.value, '');
      textfieldChange(textfield, "some value");
      expect(input.value, 'some value');

      // Wait for upgrade event
    });
  });


}
