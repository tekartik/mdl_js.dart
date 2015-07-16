library tekartik.mdj_js.classes;

final String prefix = "mdl";
String prefixed(String klass) => "$prefix-$klass";
final String jsPrefix = prefixed("js");
String jsPrefixed(String klass) => "$jsPrefix-$klass";

final String button = prefixed("button");
final String textfield = prefixed("textfield");
final String progress = prefixed("progress");
final String spinner = prefixed("spinner");

final String jsRippleEffect = jsPrefixed("ripple-effect");