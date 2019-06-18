import 'package:process_run/shell.dart';

Future main() async {
  var shell = Shell();

  await shell.run('''

  dartanalyzer --fatal-warnings lib test tool example
  dartfmt -w lib test tool example --set-exit-if-changed

  pub run test -p vm,chrome -j 1
  ''');

  await shell.run('''
    # pub run build_runner test -- -p vm -j 1 test/multiplatform test/vm
    # Currently running as 2 commands
    pub run build_runner test -- -p chrome,vm
  ''');
}
