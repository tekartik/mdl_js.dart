@TestOn('browser')
library tekartik_mdl_js.test.mdl_js_loader_test.dart;

import 'dart:js' as js;

import 'package:dev_test/test.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';

void main() {
  group('loader', () {
    test('load', () async {
      // calling componentHandler should fail
      /* nnbd failure
      bool success;
      try {
        componentHandler;
        success = false;
      } catch (e) {
        success = true;
      }
      expect(success, isTrue);
       */

      expect(js.context['componentHandler'], isNull);
      expect(jsComponentHandler, isNull);
      await (loadMdlJs());
      expect(js.context['componentHandler'], isNotNull);
      expect(jsComponentHandler, isNotNull);
      //componentHandler;
    });
  });
}
