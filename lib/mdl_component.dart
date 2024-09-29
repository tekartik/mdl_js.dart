library;

import 'dart:async';
import 'dart:html' as html;

Stream onComponentUpgraded(html.Element element) =>
    element.on['mdl-componentupgraded'];

bool isComponentUpgraded(html.Element element) =>
    element.dataset['upgraded'] != null;

/// eventCount: number of event to wait for
Future whenComponentUpgraded(html.Element element) {
  if (isComponentUpgraded(element)) {
    return Future.value();
  }
  final stream = onComponentUpgraded(element);
  return stream.first;
}
