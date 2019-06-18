import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:pub_semver/pub_semver.dart';

Version parsePlatformVersion(String text) {
  return Version.parse(text.split(' ').first);
}

Future main() async {
  var shell = Shell();

  await shell.run('''

  dartanalyzer --fatal-warnings lib test tool example
  dartfmt -w lib test tool example --set-exit-if-changed

  pub run test -p vm,chrome -j 1
  ''');

  var dartVersion = parsePlatformVersion(Platform.version);
  if (dartVersion >= Version(2, 4, 0, pre: 'dev')) {
    await shell.run('''
    pub run build_runner test -- -p chrome,vm
  ''');
  }
}
