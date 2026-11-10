// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

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

      expect(globalContext['componentHandler'], isNull);
      expect(jsComponentHandler, isNull);
      await (loadCdnMdlJs());
      await (loadCdnMdlCss());
      expect(globalContext['componentHandler'], isNotNull);
      expect(jsComponentHandler, isNotNull);
      //componentHandler;
    });
  });
}
