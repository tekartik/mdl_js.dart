@TestOn('browser')
library tekartik_mdl_js.test.mdl_js_cdn_loader_test.dart;

import 'dart:js' as js;

import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:test/test.dart';

void main() {
  group('cdn_loader', () {
    test('load_js_css', () async {
      /* nnbd failure
      // calling componentHandler should fail
      bool success;
      try {
        componentHandler;
        success = false;
      } catch (e) {
        success = true;
      }
       */

      expect(js.context['componentHandler'], isNull);
      expect(jsComponentHandler, isNull);
      await (loadCdnMdlJs());
      await (loadCdnMdlCss());
      expect(js.context['componentHandler'], isNotNull);
      expect(jsComponentHandler, isNotNull);
      //componentHandler;
    });
  });
}
