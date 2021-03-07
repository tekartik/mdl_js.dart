@TestOn('browser')
library tekartik_mdl_js.test.mdl_version_test.dart;

import 'dart:convert';
import 'dart:html';

import 'package:dev_test/test.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_mdl_js/mdl_version.dart';

void main() {
  group('version', () {
    test('upgrade', () async {
      // check the version defined
      final minJs = await HttpRequest.getString(
          'packages/tekartik_mdl_js/js/material.min.js');
      final lines = LineSplitter.split(minJs);
      Version? minJsVersion;
      for (final line in lines) {
        final prefix = '@version v';
        final index = line.indexOf(prefix);
        if (index != -1) {
          minJsVersion = Version.parse(line.substring(index + prefix.length));
          break;
        }
      }
      expect(minJsVersion, version);
    });
  });
}
