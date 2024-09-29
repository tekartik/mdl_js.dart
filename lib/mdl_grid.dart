library;

import 'dart:html' as html;
import 'src/import.dart' as mdl;

html.DivElement gridCreate() {
  final classes = [mdl.grid];

  final grid = html.DivElement()..classes.addAll(classes);
  return grid;
}

html.DivElement cellCreate(int column, {int? tablet, int? phone}) {
  final classes = [mdl.cell];
  classes.add(mdl.cellCol(column));
  if (tablet != null) {
    classes.add(mdl.cellColTablet(tablet));
  }
  if (phone != null) {
    classes.add(mdl.cellColPhone(phone));
  }

  final cell = html.DivElement()..classes.addAll(classes);
  return cell;
}
