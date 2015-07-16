library tekartik.mdj_js.classes;

final String prefix = "mdl";
String prefixed(String klass) => "$prefix-$klass";
final String jsPrefix = prefixed("js");
String jsPrefixed(String klass) => "$jsPrefix-$klass";

final String button = prefixed("button");
final String textfield = prefixed("textfield");
final String progress = prefixed("progress");
final String spinner = prefixed("spinner");
final String slider = prefixed("slider");
final String jsSlider = jsPrefixed("slider");

final String jsRippleEffect = jsPrefixed("ripple-effect");

final String layout = prefixed("layout");
final String jsLayout = jsPrefixed("layout");
final String layoutOverlayDrawerButton = "$layout--overlay-drawer-button";
final String layoutFixedDrawer = "$layout--fixed-drawer";
final String layoutDrawer = "${layout}__drawer";
final String layoutTitle = "$layout-title";

final String isUpgraded = "is-upgraded";