@TestOn("browser")
library tekartik.mdl_js.compoenent_handler_test;

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:test/test.dart';
import 'dart:html';
import 'dart:async';

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

      //print(new Map.from(textfield.attributes));
      textfieldUpgrade(textfield);
      //print(new Map.from(textfield.attributes));
      expect(isComponentUpgraded(textfield), true);
      expect(textfield.attributes['data-upgraded'], contains('MaterialTextfield'));
    });

    test('autoUpgrade', () async {
      var div = document.createElement('div');
      Future upgraded = div.on['mdl-componentupgraded'].first;
      div.className = 'mdl-textfield';
      expect(div.attributes['data-upgraded'], isNull);
      componentHandler.upgradeElement(div);
      expect(div.attributes['data-upgraded'], isNull);
      div.className = 'mdl-textfield mdl-js-textfield';
      componentHandler.upgradeElement(div);
      expect(div.attributes['data-upgraded'], contains('MaterialTextfield'));
      // Wait for upgrade event
      await upgraded;
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
