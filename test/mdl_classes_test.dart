import 'package:dev_test/test.dart';
import 'package:tekartik_mdl_js/mdl_classes.dart';

void main() {
  group('classes', () {
    test('prefix', () async {
      expect(prefixed('button'), 'mdl-button');
      expect(jsPrefixed('button'), 'mdl-js-button');
    });

    test('list', () {
      expect(listItemAvatar, 'mdl-list__item-avatar');
    });
  });
}
