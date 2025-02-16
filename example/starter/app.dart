// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';
// ignore: deprecated_member_use
import 'dart:html';

import 'package:tekartik_mdl_js/mdl_js_loader.dart';

bool isRelease = true;

Future main() async {
  assert(() {
    isRelease = false;
    return true;
  }());

  if (isRelease) {
    await Future.wait(
        [loadCdnMdlCss(), loadCdnMdlJs(), loadCdnMaterialIconsCss()]);
  } else {
    await Future.wait([loadMdlCss(), loadMdlJs(), loadMaterialIconsCss()]);
  }

  document.body!.querySelector('#app_content')!.classes.add('app-ready');
}
