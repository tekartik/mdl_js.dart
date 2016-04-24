import 'package:dev_test/test.dart';
import 'mdl_button_test.dart' as mdl_button_test;
import 'mdl_classes_test.dart' as mdl_classes_test;
import 'mdl_js_component_handler_test.dart' as mdl_js_component_handler_test;
import 'mdl_layout_test.dart' as mdl_layout_test;
import 'mdl_textfield_test.dart' as mdl_textfield_test;

main() {
  group('all', () {
    mdl_button_test.main();
    mdl_classes_test.main();
    mdl_js_component_handler_test.main();
    mdl_layout_test.main();
    mdl_textfield_test.main();
  });
}