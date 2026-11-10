import 'package:web/web.dart' as web;

/// Adds [classes] to [element].
void addClasses(web.Element element, Iterable<String> classes) {
  for (var klass in classes) {
    element.classList.add(klass);
  }
}

/// A new [tag] element with [classes].
web.Element createElementWithClasses(String tag, Iterable<String> classes) {
  var element = web.document.createElement(tag);
  addClasses(element, classes);
  return element;
}
