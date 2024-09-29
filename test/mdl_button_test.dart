@TestOn('browser')
library;

import 'dart:html';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';

void main() {
  group('button', () {
    setUp(() async {
      await (loadMdlJs());
    });

    test('button-upgrade-no-js', () async {
      var button = document.createElement('button');
      button.className = 'mdl-button';
      expect(button.attributes['data-upgraded'], isNull);
      expect(isComponentUpgraded(button), false);
      componentHandler!.upgradeElement(button);
      expect(isComponentUpgraded(button), false);
      componentHandler!.upgradeElement(button, jsClass: materialButtonType);
      expect(isComponentUpgraded(button), true);
      expect(button.attributes['data-upgraded'], ',MaterialButton');
    });

    test('upgrade_simple', () async {
      var button = document.createElement('button');
      button.className = 'mdl-button mdl-js-button';
      //Future upgraded = button.on['mdl-componentupgraded'].first;
      //Future upgraded = onComponentUpgraded(button).first; //
      final upgraded = whenComponentUpgraded(button);
      expect(isComponentUpgraded(button), false);
      expect(button.attributes['data-upgraded'], isNull);
      componentHandler!
          .upgradeElement(button); //, jsClass: materialButtonType);
      expect(button.attributes['data-upgraded'], contains('MaterialButton'));
      expect(button.attributes['data-upgraded'],
          isNot(contains('MaterialRipple')));
      expect(isComponentUpgraded(button), true);
      // Wait for upgrade event
      await upgraded;
      //print(button.outerHtml);
    });

    test('upgrade', () async {
      var button = document.createElement('button');
      button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
      //Future upgraded = button.on['mdl-componentupgraded'].first;
      //Future upgraded = onComponentUpgraded(button).first; //
      final upgraded = whenComponentUpgraded(button);

      expect(button.attributes['data-upgraded'], isNull);
      componentHandler!
          .upgradeElement(button); //, jsClass: materialButtonType);
      expect(button.attributes['data-upgraded'], contains('MaterialButton'));
      expect(button.attributes['data-upgraded'], contains('MaterialRipple'));
      // Wait for upgrade event
      await upgraded;
      //print(button.outerHtml);
    });

    test('upgrade_with_class', () async {
      var button = document.createElement('button');
      button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
      //Future upgraded = button.on['mdl-componentupgraded'].first;
      //Future upgraded = onComponentUpgraded(button).first; //
      var upgraded = onComponentUpgraded(button).first;

      expect(button.attributes['data-upgraded'], isNull);
      componentHandler!.upgradeElement(button, jsClass: materialButtonType);
      expect(button.attributes['data-upgraded'], contains('MaterialButton'));
      expect(button.attributes['data-upgraded'],
          isNot(contains('MaterialRipple')));
      // Wait for upgrade event
      await upgraded;

      upgraded = onComponentUpgraded(button).first;
      componentHandler!.upgradeElement(button, jsClass: materialRippleType);
      expect(button.attributes['data-upgraded'], contains('MaterialButton'));
      expect(button.attributes['data-upgraded'], contains('MaterialRipple'));
      //print(button.outerHtml);
      await upgraded;
    });
  });
}
