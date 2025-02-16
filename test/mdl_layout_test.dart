// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_layout.dart';
import 'package:test/test.dart';

void main() {
  group('layout', () {
    setUp(() async {
      await (loadMdlJs());
    });

    test('upgrade', () async {
      var layout = layoutCreate();
      DivElement().append(layout); // need container
      expect(layout.attributes['data-upgraded'], isNull);
      layoutUpgrade(layout);
      expect(layout.attributes['data-upgraded'], contains('MaterialLayout'));
    });
  });
}
