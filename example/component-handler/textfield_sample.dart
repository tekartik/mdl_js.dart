// ignore_for_file: deprecated_member_use_from_same_package

import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_mdl_js/mdl_import.dart';
import 'package:web/web.dart' as web;

void addTextfieldForm() {
  /*
  var form = web.document.createElement('form');
  form.setAttribute('action', '#');
  var div = web.document.createElement('div');
  div.className = 'mdl-textfield mdl-js-textfield textfield-demo';
  var input = web.document.createElement('input');
  input.className = 'mdl-textfield__input';
  input.setAttribute('type', 'text');
  input.setAttribute('pattern', '[0-9]*');
  input.setAttribute('id', 'sample2');
  var label = web.document.createElement('label');
  label.className = 'mdl-textfield__label';
  label.setAttribute('for', 'sample2');
  label.textContent = 'Number...';
  var span = web.document.createElement('span');
  span.className = 'mdl-textfield__error';
  span.textContent = 'Input is not a number!';
  div.append(input);
  div.append(label);
  div.append(span);
  form.append(div);
  //componentHandler.upgradeElement(div);//, materialTextfieldType);
  */
  TextField textField;
  late TextField thatChangeTextField;
  thatChangeTextField =
      TextField(
          label: 'withLabel',
          value: 'to change',
          errorLabel: 'Take care',
          floatingLabel: true,
        )
        ..onChange.listen((_) {
          // ignore: avoid_print
          print('new value ${thatChangeTextField.value}');
        });
  textField = thatChangeTextField;
  web.document.getElementById('container')!.append(textField.element!);
  textField = TextField(value: 'My EditField');
  web.document.getElementById('container')!.append(textField.element!);
  textField = TextField(
    label: 'withLabel',
    value: 'My EditField',
    numeric: true,
    errorLabel: 'Take care',
    floatingLabel: true,
  );
  web.document.getElementById('container')!.append(textField.element!);
  textField.label = 'Some label';
  //textfieldChange(div, '1324');
}

void addOldTextfieldForm() {
  var form = web.document.createElement('form');
  form.setAttribute('action', '#');
  var div = web.document.createElement('div');
  div.className = 'mdl-textfield mdl-js-textfield textfield-demo';
  var input = web.document.createElement('input');
  input.className = 'mdl-textfield__input';
  input.setAttribute('type', 'text');
  input.setAttribute('pattern', '[0-9]*');
  input.setAttribute('id', 'sample2');
  var label = web.document.createElement('label');
  label.className = 'mdl-textfield__label';
  label.setAttribute('for', 'sample2');
  label.textContent = 'Number...';
  var span = web.document.createElement('span');
  span.className = 'mdl-textfield__error';
  span.textContent = 'Input is not a number!';
  div.append(input);
  div.append(label);
  div.append(span);
  form.append(div);
  componentHandler!.upgradeElement(div); //, materialTextfieldType);
  web.document.getElementById('container')!.append(form);
  textfieldChange(div, '1324');
}

void main() {
  addTextfieldForm();
  Timer(const Duration(milliseconds: 2000), addTextfieldForm);

  addOldTextfieldForm();
  Timer(const Duration(milliseconds: 2000), addOldTextfieldForm);
}

//}, 0);
