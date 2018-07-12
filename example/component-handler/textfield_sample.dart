import 'package:tekartik_mdl_js/mdl_import.dart';

void addTextfieldForm() {
  /*
  var form = document.createElement("form");
  form.setAttribute("action", "#");
  var div = document.createElement("div");
  div.className = "mdl-textfield mdl-js-textfield textfield-demo";
  var input = document.createElement("input");
  input.className = "mdl-textfield__input";
  input.setAttribute("type", "text");
  input.setAttribute("pattern", "[0-9]*");
  input.setAttribute("id", "sample2");
  var label = document.createElement("label");
  label.className = "mdl-textfield__label";
  label.setAttribute("for", "sample2");
  label.text = "Number...";
  var span = document.createElement("span");
  span.className = "mdl-textfield__error";
  span.text = "Input is not a number!";
  div.append(input);
  div.append(label);
  div.append(span);
  form.append(div);
  //componentHandler.upgradeElement(div);//, materialTextfieldType);
  */
  TextField textField;
  var thatChangeTextField;
  thatChangeTextField = new TextField(
      label: "withLabel",
      value: "to change",
      errorLabel: "Take care",
      floatingLabel: true)
    ..onChange.listen((_) {
      print('new value ${thatChangeTextField.value}');
    });
  textField = thatChangeTextField as TextField;
  document.getElementById('container').append(textField.element);
  textField = new TextField(value: "My EditField");
  document.getElementById('container').append(textField.element);
  textField = new TextField(
      label: "withLabel",
      value: "My EditField",
      numeric: true,
      errorLabel: "Take care",
      floatingLabel: true);
  document.getElementById('container').append(textField.element);
  textField.label = "Some label";
  //textfieldChange(div, "1324");
}

void addOldTextfieldForm() {
  var form = document.createElement("form");
  form.setAttribute("action", "#");
  var div = document.createElement("div");
  div.className = "mdl-textfield mdl-js-textfield textfield-demo";
  var input = document.createElement("input");
  input.className = "mdl-textfield__input";
  input.setAttribute("type", "text");
  input.setAttribute("pattern", "[0-9]*");
  input.setAttribute("id", "sample2");
  var label = document.createElement("label");
  label.className = "mdl-textfield__label";
  label.setAttribute("for", "sample2");
  label.text = "Number...";
  var span = document.createElement("span");
  span.className = "mdl-textfield__error";
  span.text = "Input is not a number!";
  div.append(input);
  div.append(label);
  div.append(span);
  form.append(div);
  componentHandler.upgradeElement(div); //, materialTextfieldType);
  document.getElementById('container').append(form);
  textfieldChange(div, "1324");
}

main() {
  addTextfieldForm();
  new Timer(new Duration(milliseconds: 2000), addTextfieldForm);

  addOldTextfieldForm();
  new Timer(new Duration(milliseconds: 2000), addOldTextfieldForm);
}

//}, 0);
