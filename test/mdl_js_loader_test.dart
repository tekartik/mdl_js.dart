@TestOn('browser')
library;

import 'dart:js' as js;

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';

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
