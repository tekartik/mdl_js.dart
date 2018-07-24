@TestOn("browser")
library tekartik_mdl_js.test.mdl_js_cdn_loader_test.dart;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:test/test.dart';
import 'dart:js' as js;

void main() {
  group('cdn_loader', () {
    test('load_js_css', () async {
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
      expect(jsComponentHandler, isNull);
      await (loadCdnMdlJs());
      await (loadCdnMdlCss());
      expect(js.context['componentHandler'], isNotNull);
      expect(jsComponentHandler, isNotNull);
      //componentHandler;
    }, skip: "content-shell");
  });
}
