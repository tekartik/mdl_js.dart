// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_layout.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  group('layout', () {
    setUp(() async {
      await (loadMdlJs());
    });

    test('upgrade', () async {
      var layout = layoutCreate();
      web.HTMLDivElement().append(layout); // need container
      expect(layout.getAttribute('data-upgraded'), isNull);
      layoutUpgrade(layout);
      expect(layout.getAttribute('data-upgraded'), contains('MaterialLayout'));
    });

    test('title', () {
      var title = layoutTitleCreate(title: '<b>bold</b> & co');
      expect(title.textContent, '<b>bold</b> & co');
      expect(title.children.length, 0);
    });

    test('overlayDrawerButton', () {
      expect(
        layoutCreate().classList.contains('mdl-layout--overlay-drawer-button'),
        isFalse,
      );
      expect(
        layoutCreate(
          overlayDrawerButton: true,
        ).classList.contains('mdl-layout--overlay-drawer-button'),
        isTrue,
      );
    });
  });
}
