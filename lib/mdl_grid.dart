library tekartik.mdj_js.grid;

import 'dart:html' as html;
import "mdl_classes.dart" as mdl;
import "mdl_js.dart" as mdl;

html.DivElement gridCreate() {
  List<String> classes = [mdl.grid];

  html.DivElement grid = new html.DivElement()
    ..classes.addAll(classes);
  return grid;
}

html.DivElement cellCreate(int column, {int tablet, int phone}) {
  List<String> classes = [mdl.cell];
  classes.add(mdl.cellCol(column));
  if (tablet != null) {
    classes.add(mdl.cellColTablet(tablet));
  }
  if (phone != null) {
    classes.add(mdl.cellColPhone(phone));
  }

  html.DivElement cell = new html.DivElement()
    ..classes.addAll(classes);
  return cell;
}

