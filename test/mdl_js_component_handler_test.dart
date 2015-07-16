@TestOn("browser")
library tekartik.mdl_js.compoenent_handler_test;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:test/test.dart';
import 'dart:html';
import 'dart:async';

void main() {

  group('component_handler', () {
    setUp(() async {
      await(loadMdlJs());
    });
    group('button', () {
      test('button', () async {
        var button = document.createElement('button');
        button.className = 'mdl-button mdl-js-button mdl-js-ripple-effect';
        Future upgraded = button.on['mdl-componentupgraded'].first;
        expect(button.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(button, jsClass: materialButtonType);
        expect(button.attributes['data-upgraded'], isNotNull);
        // Wait for upgrade event
        await upgraded;
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
        var div = document.createElement('div');
        Future upgraded = div.on['mdl-componentupgraded'].first;
        div.className = 'mdl-spinner mdl-js-spinner';
        expect(div.attributes['data-upgraded'], isNull);
        componentHandler.upgradeElement(div);
        expect(div.attributes['data-upgraded'], contains('MaterialSpinner'));
        // Wait for upgrade event
        await upgraded;
      });
    });


  });


}
