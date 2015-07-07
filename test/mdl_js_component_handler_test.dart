@TestOn("browser")
library tekartik.mdl_js.compoenent_handler_test;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:test/test.dart';
import 'dart:html';
import 'dart:js' as js;
import 'dart:async';

void main() {

  group('component_handler', () {
    setUp(() async {
      await(loadMdlJs());
    });
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

  });


}
