@TestOn("browser")
library tekartik.mdl_js.compoenent_handler_test;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:test/test.dart';
import 'dart:html';
import 'dart:async';

void main() {

  group('component_handler', () {
    setUp(() async {
      await(loadMdlJs());
    });

    //_skip_test(_1, _2) {}

    group('button', () {
     test('button', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        //Future upgraded = button.on['mdl-componentupgraded'].first;
        //Future upgraded = onComponentUpgraded(button).first; //
        Future upgraded = whenComponentUpgraded(button);

        expect(button.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(button, jsClass: materialButtonType);
        expect(button.attributes['data-upgraded'], isNotNull);
        //print(button.outerHtml);
        // Wait for upgrade event
        await upgraded;
        //print(button.outerHtml);
      });

      test('button-simple', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button';
        expect(button.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(button, jsClass: materialButtonType);
        //print(button.attributes['data-upgraded']);
        expect(button.attributes['data-upgraded'], contains('MaterialButton'));
      });

      test('bug_804', () async {
        // https://github.com/google/material-design-lite/issues/804
        var button = document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        Future upgraded = button.on['mdl-componentupgraded'].skip(1).first;
        expect(button.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(button, jsClass: materialButtonType);
        expect(button.attributes['data-upgraded'], contains('MaterialButton'));
        expect(button.attributes['data-upgraded'].contains('MaterialRipple'), isFalse);
        componentHandler.upgradeElement(button, jsClass: materialRippleType);
        expect(button.attributes['data-upgraded'], contains('MaterialButton'));
        expect(button.attributes['data-upgraded'], contains('MaterialRipple'));
        // Wait for upgrade event
        await upgraded;
      });

      test('autoUpgrade', () async {
        var button = document.createElement('button');
        Future upgraded = button.on['mdl-componentupgraded'].skip(1).first;
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        expect(button.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(button);
        expect(button.attributes['data-upgraded'], contains('MaterialButton'));
        expect(button.attributes['data-upgraded'], contains('MaterialRipple'));
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('upgrade', () {
      test('twice', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        Future upgraded = whenComponentUpgraded(button, 2);
        expect(componentHandler.upgradeElement(button, jsClass: materialButtonType), 1);
        expect(componentHandler.upgradeElement(button, jsClass: materialButtonType), 0);
        expect(componentHandler.upgradeElement(button, jsClass: materialRippleType), 1);
        expect(componentHandler.upgradeElement(button, jsClass: materialRippleType), 0);
        await upgraded;
        //await onComponentUpgraded(button).first;
      });


      test('is_upgraded', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button';
        expect(isComponentUpgraded(button), false);
        componentHandler.upgradeElement(button);
        expect(isComponentUpgraded(button), true);
      });

      test('if_or_when_upgraded_before', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button';
        Future upgraded = whenComponentUpgraded(button);
        componentHandler.upgradeElement(button);
        await upgraded;
      });

      test('if_or_when_upgraded_before', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button';
        componentHandler.upgradeElement(button);
        Future upgraded = whenComponentUpgraded(button);
        await upgraded;
      });


      test('future', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        await componentHandler.upgrade(button);
      });


    });
    group('textfield', () {
      test('autoUpgrade', () async {
        var div = document.createElement('div');
        Future upgraded = div.on['mdl-componentupgraded'].first;
        div.className = 'mdl-textfield';
        expect(div.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(div);
        expect(div.attributes['data-upgraded'], contains('MaterialTextfield'));
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('progress', () {
      test('upgrade', () async {
        var div = document.createElement('div');
        Future upgraded = div.on['mdl-componentupgraded'].first;
        div.className = 'mdl-progress mdl-js-progress';
        expect(div.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(div, jsClass: materialProgressType);
        expect(div.attributes['data-upgraded'], contains('MaterialProgress'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        var div = document.createElement('div');
        Future upgraded = div.on['mdl-componentupgraded'].first;
        div.className = 'mdl-progress mdl-js-progress';
        expect(div.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(div);
        expect(div.attributes['data-upgraded'], contains('MaterialProgress'));
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('spinner', () {
      test('upgrade', () async {
        var div = document.createElement('div');
        Future upgraded = div.on['mdl-componentupgraded'].first;
        div.className = 'mdl-spinner mdl-js-spinner';
        expect(div.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(div, jsClass: materialSpinnerType);
        expect(div.attributes['data-upgraded'], contains('MaterialSpinner'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        var input = document.createElement('div');
        Future upgraded = input.on['mdl-componentupgraded'].first;
        input.className = 'mdl-spinner mdl-js-spinner';
        expect(input.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(input);
        expect(input.attributes['data-upgraded'], contains('MaterialSpinner'));
        // Wait for upgrade event
        await upgraded;
      });
    });

    group('slider', () {
      test('upgrade', () async {
        DivElement inputWrapper = document.createElement('div');
        InputElement input = document.createElement('input');
        Future upgraded = input.on['mdl-componentupgraded'].first;
        input.className = 'mdl-slider mdl-js-slider';
        input.type = "range";
        inputWrapper.append(input);
        expect(input.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(input, jsClass: materialSliderType);
        expect(input.attributes['data-upgraded'], contains('MaterialSlider'));
        // Wait for upgrade event
        await upgraded;
      });
      test('autoUpgrade', () async {
        DivElement inputWrapper = document.createElement('div');
        InputElement input = document.createElement('input');
        Future upgraded = input.on['mdl-componentupgraded'].first;
        input.className = 'mdl-slider mdl-js-slider';
        input.type = "range";
        inputWrapper.append(input);
        expect(input.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(input);
        expect(input.attributes['data-upgraded'], contains('MaterialSlider'));
        //print(inputWrapper.outerHtml);
        // Wait for upgrade event
        await upgraded;
      });
    });


  });


}
