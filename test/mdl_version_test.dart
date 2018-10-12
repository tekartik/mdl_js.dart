@TestOn("browser")
library tekartik_mdl_js.test.mdl_version_test.dart;

import 'package:tekartik_mdl_js/mdl_version.dart';
import 'package:dev_test/test.dart';
import 'dart:html';
import 'dart:convert';
import 'package:pub_semver/pub_semver.dart';

void main() {
  group('version', () {
    test('upgrade', () async {
      // check the version defined
      String minJs = await HttpRequest.getString(
          "packages/tekartik_mdl_js/js/material.min.js");
      Iterable<String> lines = LineSplitter.split(minJs);
      Version minJsVersion;
      for (String line in lines) {
        String prefix = "@version v";
        int index = line.indexOf(prefix);
        if (index != -1) {
          minJsVersion = Version.parse(line.substring(index + prefix.length));
          break;
        }
      }
      expect(minJsVersion, version);
    });
  });
}
