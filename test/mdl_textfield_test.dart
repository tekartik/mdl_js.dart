// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'dart:async';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_textfield.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  group('textfield', () {
    setUp(() async {
      await (loadMdlJs());
    });

    web.HTMLDivElement createTextfield() {
      final textfield = web.HTMLDivElement();
      textfield.className = 'mdl-textfield';
      final input = web.HTMLInputElement();
      input.className = 'mdl-textfield__input';
      input.setAttribute('type', 'text');
      textfield.append(input);
      return textfield;
    }

    test('upgrade', () async {
      final textfield = createTextfield();

      expect(isComponentUpgraded(textfield), false);
      expect(textfield.getAttribute('data-upgraded'), isNull);

      //print(new Map.from(textfield.attributes));
      textfieldUpgrade(textfield);
      //print(new Map.from(textfield.attributes));
      expect(isComponentUpgraded(textfield), true);
      expect(
        textfield.getAttribute('data-upgraded'),
        contains('MaterialTextfield'),
      );
    });

    test('TextField input id', () {
      var field = TextField(label: 'no id');
      var input = field.element!.querySelector('input')!;
      var label = field.element!.querySelector('label')!;
      expect(input.id, isEmpty);
      expect(label.getAttribute('for'), isNull);
      field = TextField(label: 'with id', inputId: 'my');
      input = field.element!.querySelector('input')!;
      label = field.element!.querySelector('label')!;
      expect(input.id, 'my_input');
      expect(label.getAttribute('for'), 'my_input');
    });

    test('autoUpgrade', () async {
      var div = web.document.createElement('div');
      Future upgraded = onComponentUpgraded(div).first;
      div.className = 'mdl-textfield';
      expect(div.getAttribute('data-upgraded'), isNull);
      componentHandler!.upgradeElement(div);
      expect(div.getAttribute('data-upgraded'), isNull);
      div.className = 'mdl-textfield mdl-js-textfield';
      componentHandler!.upgradeElement(div);
      expect(div.getAttribute('data-upgraded'), contains('MaterialTextfield'));
      // Wait for upgrade event
      await upgraded;
    });

    test('change', () async {
      final textfield = createTextfield();
      final input = textfield.querySelector('input') as web.HTMLInputElement;
      textfieldUpgrade(textfield);
      expect(
        textfield.getAttribute('data-upgraded'),
        contains('MaterialTextfield'),
      );
      expect(input.value, '');
      textfieldChange(textfield, 'some value');
      expect(input.value, 'some value');

      // Wait for upgrade event
    });
  });
}
