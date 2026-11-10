// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:web/web.dart' as web;

bool isRelease = true;

Future main() async {
  assert(() {
    isRelease = false;
    return true;
  }());

  await Future.wait([loadMdlCss(), loadMdlJs(), loadMaterialIconsCss()]);

  web.document.body!.querySelector('#app_content')!.classList.add('app-ready');
}
