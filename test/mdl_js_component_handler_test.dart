// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'dart:async';

import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  group('component_handler', () {
    setUp(() async {
      await (loadMdlJs());
    });

    //_skip_test(_1, _2) {}

    group('button', () {
      test('bug_804', () async {
        // https://github.com/google/material-design-lite/issues/804
        var button = web.document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        Future upgraded = onComponentUpgraded(button).skip(1).first;
        expect(button.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(button, jsClass: materialButtonType);
        expect(
          button.getAttribute('data-upgraded'),
          contains('MaterialButton'),
        );
        expect(
          button.getAttribute('data-upgraded')!.contains('MaterialRipple'),
          isFalse,
        );
        componentHandler!.upgradeElement(button, jsClass: materialRippleType);
        expect(
          button.getAttribute('data-upgraded'),
          contains('MaterialButton'),
        );
        expect(
          button.getAttribute('data-upgraded'),
          contains('MaterialRipple'),
        );
        // Wait for upgrade event
        await upgraded;
      });

      test('autoUpgrade', () async {
        var button = web.document.createElement('button');
        Future upgraded = onComponentUpgraded(button).skip(1).first;
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        expect(button.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(button);
        expect(
          button.getAttribute('data-upgraded'),
          contains('MaterialButton'),
        );
        expect(
          button.getAttribute('data-upgraded'),
          contains('MaterialRipple'),
        );
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('upgrade', () {
      test('twice', () async {
        var button = web.document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        var upgradeCount = 0;
        onComponentUpgraded(button).listen((_) {
          upgradeCount++;
        });
        //Future upgraded = onComponentUpgraded(button).skip(1).first;
        componentHandler!.upgradeElement(button, jsClass: materialButtonType);
        expect(upgradeCount, 1);
        componentHandler!.upgradeElement(button, jsClass: materialButtonType);
        expect(upgradeCount, 1);
        componentHandler!.upgradeElement(button, jsClass: materialRippleType);
        expect(upgradeCount, 2);
      });

      /*
      test('if_or_when_upgraded_before', () async {
        var button = web.document.createElement('button');
        button.className = 'mdl-button';
        Future upgraded = whenComponentUpgraded(button);
        componentHandler.upgradeElement(button);
        await upgraded;
      });

      */

      test('future', () async {
        var button = web.document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        await componentHandler!.upgrade(button as web.HTMLElement);
      });
    });

    group('progress', () {
      test('upgrade', () async {
        var div = web.document.createElement('div');
        Future upgraded = onComponentUpgraded(div).first;
        div.className = 'mdl-progress mdl-js-progress';
        expect(div.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(div, jsClass: materialProgressType);
        expect(div.getAttribute('data-upgraded'), contains('MaterialProgress'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        var div = web.document.createElement('div');
        Future upgraded = onComponentUpgraded(div).first;
        div.className = 'mdl-progress mdl-js-progress';
        expect(div.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(div);
        expect(div.getAttribute('data-upgraded'), contains('MaterialProgress'));
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('spinner', () {
      test('upgrade', () async {
        var div = web.document.createElement('div');
        Future upgraded = onComponentUpgraded(div).first;
        div.className = 'mdl-spinner mdl-js-spinner';
        expect(div.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(div, jsClass: materialSpinnerType);
        expect(div.getAttribute('data-upgraded'), contains('MaterialSpinner'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        var input = web.document.createElement('div');
        Future upgraded = onComponentUpgraded(input).first;
        input.className = 'mdl-spinner mdl-js-spinner';
        expect(input.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(input);
        expect(
          input.getAttribute('data-upgraded'),
          contains('MaterialSpinner'),
        );
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('slider', () {
      test('upgrade', () async {
        final inputWrapper =
            web.document.createElement('div') as web.HTMLDivElement;
        final input =
            web.document.createElement('input') as web.HTMLInputElement;
        Future upgraded = onComponentUpgraded(input).first;
        input.className = 'mdl-slider mdl-js-slider';
        input.type = 'range';
        inputWrapper.append(input);
        expect(input.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(input, jsClass: materialSliderType);
        expect(input.getAttribute('data-upgraded'), contains('MaterialSlider'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        final inputWrapper =
            web.document.createElement('div') as web.HTMLDivElement;
        final input =
            web.document.createElement('input') as web.HTMLInputElement;
        Future upgraded = onComponentUpgraded(input).first;
        input.className = 'mdl-slider mdl-js-slider';
        input.type = 'range';
        inputWrapper.append(input);
        expect(input.getAttribute('data-upgraded'), isNull);
        componentHandler!.upgradeElement(input);
        expect(input.getAttribute('data-upgraded'), contains('MaterialSlider'));
        //print(inputWrapper.outerHtml);
        // Wait for upgrade event
        await upgraded;
      });
    });
  });
}
