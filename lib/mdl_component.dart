library tekartik.mdj_js.component;

import 'dart:html' as html;
import 'dart:async';
import 'package:tekartik_mdl_js/mdl_classes.dart' as mdl;

Stream onComponentUpgraded(html.Element element) => element.on['mdl-componentupgraded'];

bool isComponentUpgraded(html.Element element) => element.dataset['upgraded'] != null;

/// eventCount: number of event to wait for
Future whenComponentUpgraded(html.Element element, [int eventCount = 1]) {

  if (isComponentUpgraded(element) || eventCount == 0) {
    return new Future.value();
  }
  Stream stream = onComponentUpgraded(element);
  if (eventCount > 1) {
    stream.skip(eventCount - 1);
  }
  return stream.first;
}
