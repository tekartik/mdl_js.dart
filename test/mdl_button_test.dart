// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  group('button', () {
    setUp(() async {
      await (loadMdlJs());
    });

    test('button-upgrade-no-js', () async {
      var button = web.document.createElement('button');
      button.className = 'mdl-button';
      expect(button.getAttribute('data-upgraded'), isNull);
      expect(isComponentUpgraded(button), false);
      componentHandler!.upgradeElement(button);
      expect(isComponentUpgraded(button), false);
      componentHandler!.upgradeElement(button, jsClass: materialButtonType);
      expect(isComponentUpgraded(button), true);
      expect(button.getAttribute('data-upgraded'), ',MaterialButton');
    });

    test('upgrade_simple', () async {
      var button = web.document.createElement('button');
      button.className = 'mdl-button mdl-js-button';
      //Future upgraded = onComponentUpgraded(button).first;
      //Future upgraded = onComponentUpgraded(button).first; //
      final upgraded = whenComponentUpgraded(button);
      expect(isComponentUpgraded(button), false);
      expect(button.getAttribute('data-upgraded'), isNull);
      componentHandler!.upgradeElement(
        button,
      ); //, jsClass: materialButtonType);
      expect(button.getAttribute('data-upgraded'), contains('MaterialButton'));
      expect(
        button.getAttribute('data-upgraded'),
        isNot(contains('MaterialRipple')),
      );
      expect(isComponentUpgraded(button), true);
      // Wait for upgrade event
      await upgraded;
      //print(button.outerHtml);
    });

    test('upgrade', () async {
      var button = web.document.createElement('button');
      button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
      //Future upgraded = onComponentUpgraded(button).first;
      //Future upgraded = onComponentUpgraded(button).first; //
      final upgraded = whenComponentUpgraded(button);

      expect(button.getAttribute('data-upgraded'), isNull);
      componentHandler!.upgradeElement(
        button,
      ); //, jsClass: materialButtonType);
      expect(button.getAttribute('data-upgraded'), contains('MaterialButton'));
      expect(button.getAttribute('data-upgraded'), contains('MaterialRipple'));
      // Wait for upgrade event
      await upgraded;
      //print(button.outerHtml);
    });

    test('upgrade_with_class', () async {
      var button = web.document.createElement('button');
      button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
      //Future upgraded = onComponentUpgraded(button).first;
      //Future upgraded = onComponentUpgraded(button).first; //
      var upgraded = onComponentUpgraded(button).first;

      expect(button.getAttribute('data-upgraded'), isNull);
      componentHandler!.upgradeElement(button, jsClass: materialButtonType);
      expect(button.getAttribute('data-upgraded'), contains('MaterialButton'));
      expect(
        button.getAttribute('data-upgraded'),
        isNot(contains('MaterialRipple')),
      );
      // Wait for upgrade event
      await upgraded;

      upgraded = onComponentUpgraded(button).first;
      componentHandler!.upgradeElement(button, jsClass: materialRippleType);
      expect(button.getAttribute('data-upgraded'), contains('MaterialButton'));
      expect(button.getAttribute('data-upgraded'), contains('MaterialRipple'));
      //print(button.outerHtml);
      await upgraded;
    });
  });
}
