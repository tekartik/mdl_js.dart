/// MDL component upgrade events.
@Deprecated('Do no use')
library;

import 'dart:async';

import 'package:web/web.dart' as web;

const _upgradedEvent = web.EventStreamProvider<web.Event>(
  'mdl-componentupgraded',
);

/// The `mdl-componentupgraded` events of [element].
Stream<web.Event> onComponentUpgraded(web.Element element) =>
    _upgradedEvent.forTarget(element);

/// Whether MDL upgraded [element] (it has a `data-upgraded` attribute).
bool isComponentUpgraded(web.Element element) =>
    element.getAttribute('data-upgraded') != null;

/// Completes once [element] is upgraded.
Future whenComponentUpgraded(web.Element element) {
  if (isComponentUpgraded(element)) {
    return Future.value();
  }
  final stream = onComponentUpgraded(element);
  return stream.first;
}
