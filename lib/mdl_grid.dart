/// MDL grid.
@Deprecated('Do no use')
library;

import 'package:web/web.dart' as web;

import 'src/dom_prv.dart';
import 'src/import.dart' as mdl;

/// A new grid.
web.HTMLDivElement gridCreate() {
  return web.HTMLDivElement()..classList.add(mdl.grid);
}

/// A new cell of [column] columns ([tablet] and [phone] columns).
web.HTMLDivElement cellCreate(int column, {int? tablet, int? phone}) {
  final classes = [mdl.cell];
  classes.add(mdl.cellCol(column));
  if (tablet != null) {
    classes.add(mdl.cellColTablet(tablet));
  }
  if (phone != null) {
    classes.add(mdl.cellColPhone(phone));
  }

  final cell = web.HTMLDivElement();
  addClasses(cell, classes);
  return cell;
}
