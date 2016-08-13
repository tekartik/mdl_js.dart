library tekartik.mdj_js.classes;

final String prefix = "mdl";
const String _prefix = "mdl";
String prefixed(String klass) => "$prefix-$klass";
final String jsPrefix = prefixed("js");
String jsPrefixed(String klass) => "$jsPrefix-$klass";

final String button = prefixed("button");
final String jsButton = jsPrefixed("button");

final String buttonRaised = "${button}--raised";
final String buttonColored = "${button}--colored";

final String textfield = prefixed("textfield");
final String progress = prefixed("progress");
final String spinner = prefixed("spinner");
final String slider = prefixed("slider");
final String jsSlider = jsPrefixed("slider");
final String grid = prefixed("grid");
final String cell = prefixed("cell");
String cellCol(int n) => prefixed("cell--$n-col");
String cellColTablet(int n) => "${cellCol(n)}-tablet";
String cellColPhone(int n) => "${cellCol(n)}-phone";

final String jsRippleEffect = jsPrefixed("ripple-effect");

final String layout = prefixed("layout");
final String jsLayout = jsPrefixed("layout");
final String layoutFixedDrawer = "$layout--fixed-drawer";
final String layoutFixedHeader = "$layout--fixed-header";
final String layoutDrawer = "${layout}__drawer";
final String layoutHeader = "${layout}__header";
final String layoutContent = "${layout}__content";

final String layoutHeaderTransparent = "${layoutHeader}--transparent";
final String layoutOverlayDrawerButton = "$layout--overlay-drawer-button";
final String layoutLargeScreenOnly = "${layout}--large-screen-only";

final String layoutSpacer = "${layout}-spacer";
final String layoutHeaderRow = "${layoutHeader}-row";
final String layoutTitle = "$layout-title";

final String navigation = prefixed("navigation");
final String navigationLink = "${navigation}__link";

final String isUpgraded = "is-upgraded";
final String isVisible = "is-visible";
final String isActive = "is-active";

const String list = "${_prefix}-list";
const String listItem = "${list}__item";
const String listItemIcon = "${listItem}-icon";
const String listItemThreeLine = "${listItem}--three-line";

const String listItemTextBody = "${listItem}-text-body";

const String listItemPrimaryContent = "${listItem}-primary-content";
const String listItemSecondaryContent = "${listItem}-secondary-content";
const String listItemSecondaryAction = "${listItem}-secondary-action";
const String listItemSecondaryInfo = "${listItem}-secondary-info";

const listItemAvatar = "${listItem}-avatar";
