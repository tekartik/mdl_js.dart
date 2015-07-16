@TestOn("browser")
library tekartik.mdl_js.loader_test;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:test/test.dart';
import 'dart:js' as js;

void main() {

  group('loader', () {
    test('load', () async {
      // calling componentHandler should fail
      bool success;
      try {
        componentHandler;
        success = false;
      } catch (e) {
        success = true;
      }
      expect(success, isTrue);

      expect(js.context['componentHandler'], isNull);
      await(loadMdlJs());
      expect(js.context['componentHandler'], isNotNull);
      componentHandler;
    });

  });


}
