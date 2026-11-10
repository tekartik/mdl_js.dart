// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('browser')
library;

import 'package:tekartik_mdl_js/mdl_button.dart';
import 'package:tekartik_mdl_js/mdl_component.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_layout.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

int _count(String selector) => web.document.querySelectorAll(selector).length;

void main() {
  const timeout = Timeout(Duration(seconds: 30));
  // Runs first, before any load (one page per test file).
  test('a handler read before the load works after it', () async {
    var handler = componentHandler!;
    await loadMdlJs();
    var button = buttonCreate();
    handler.upgradeElement(button);
    expect(isComponentUpgraded(button), isTrue);
  }, timeout: timeout);

  test('each file is added once', () async {
    await Future.wait([loadMdl(), loadMdl()]);
    await loadMdl();
    await loadMdlCss();
    await loadMaterialIconsCss();
    // Used to add a stylesheet link on each call
    expect(_count('link[href*="tekartik_mdl_js/css/material.min.css"]'), 1);
    expect(_count('link[href*="material-design-icons/material-icons.css"]'), 1);
    expect(_count('script[src*="tekartik_mdl_js/js/material.min.js"]'), 1);
  }, timeout: timeout);

  test('layout title is text', () {
    var title = layoutTitleCreate(title: '<b>bold</b> & co');
    // Used to be parsed as HTML (a b element)
    expect(title.children.length, 0);
  }, timeout: timeout);
}
