// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'dart:async';
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';
import 'package:test/test.dart';

void main() {
  group('textfield', () {
    setUp(() async {
      await (loadMdlJs());
    });

    DivElement createTextfield() {
      final textfield = DivElement();
      textfield.className = 'mdl-textfield';
      final input = InputElement();
      input.className = 'mdl-textfield__input';
      input.setAttribute('type', 'text');
      textfield.append(input);
      return textfield;
    }

    test('upgrade', () async {
      final textfield = createTextfield();

      expect(isComponentUpgraded(textfield), false);
      expect(textfield.attributes['data-upgraded'], isNull);

      //print(new Map.from(textfield.attributes));
      textfieldUpgrade(textfield);
      //print(new Map.from(textfield.attributes));
      expect(isComponentUpgraded(textfield), true);
      expect(
        textfield.attributes['data-upgraded'],
        contains('MaterialTextfield'),
      );
    });

    test('autoUpgrade', () async {
      var div = document.createElement('div');
      Future upgraded = div.on['mdl-componentupgraded'].first;
      div.className = 'mdl-textfield';
      expect(div.attributes['data-upgraded'], isNull);
      componentHandler!.upgradeElement(div);
      expect(div.attributes['data-upgraded'], isNull);
      div.className = 'mdl-textfield mdl-js-textfield';
      componentHandler!.upgradeElement(div);
      expect(div.attributes['data-upgraded'], contains('MaterialTextfield'));
      // Wait for upgrade event
      await upgraded;
    });

    test('change', () async {
      final textfield = createTextfield();
      final input = textfield.querySelector('input') as InputElement;
      textfieldUpgrade(textfield);
      expect(
        textfield.attributes['data-upgraded'],
        contains('MaterialTextfield'),
      );
      expect(input.value, '');
      textfieldChange(textfield, 'some value');
      expect(input.value, 'some value');

      // Wait for upgrade event
    });
  });
}
