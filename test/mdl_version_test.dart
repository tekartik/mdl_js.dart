@TestOn('browser')
library;

import 'dart:convert';

import 'package:http/http.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_mdl_js/mdl_version.dart';
import 'package:test/test.dart';

void main() {
  group('version', () {
    test('upgrade', () async {
      // check the version defined
      final minJs = await read(
        Uri.parse('packages/tekartik_mdl_js/js/material.min.js'),
      );

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
