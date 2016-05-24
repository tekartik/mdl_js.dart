import 'package:tekartik_mdl_js/mdl_button.dart';
import 'package:tekartik_mdl_js/mdl_list.dart';
import 'package:tekartik_mdl_js/mdl_icons.dart';
import 'package:tekartik_mdl_js/mdl_js_loader.dart';
import 'package:tekartik_mdl_js/mdl_js.dart';
import 'dart:async';
import 'dart:html';

createList() {
  Element list = listCreate();
  Element item = listItemCreate();
  Element primaryContent = listItemPrimaryContentCreate();
  primaryContent
    ..append(listItemAvatarCreate())
    ..appendText("Simple person");
  list..append(item..append(primaryContent));

  /*
  <li class="mdl-list__item mdl-list__item--three-line">
    <span class="mdl-list__item-primary-content">
      <i class="material-icons  mdl-list__item-avatar">person</i>
      <span>Bob Odenkirk</span>
      <span class="mdl-list__item-text-body">
        Bob Odinkrik played the role of Saul in Breaking Bad. Due to public fondness for the
        character, Bob stars in his own show now, called "Better Call Saul".
      </span>
    </span>
    <span class="mdl-list__item-secondary-content">
      <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
    </span>
    </li>
   */
  item = listItemCreate(threeLine: true);
  primaryContent = listItemPrimaryContentCreate();
  primaryContent
    ..append(listItemAvatarCreate())
    ..append(new SpanElement()..appendText("Simple person"))
    ..append(listItemTextBodyCreate()..appendText("Simple line"));
  Element secondaryContent = listItemSecondaryContentCreate()
    ..append(listItemSecondaryActionCreate()..append(newIcon(iconPerson)));
  list..append(item..append(primaryContent)..append(secondaryContent));

  querySelector('#container').append(list);
}

main() async {
  await Future.wait([loadMdlCss(), loadMdlJs(), loadMaterialIconsCss()]);
  print('list-sample');

  jsComponentHandler.upgradeDom();

  createList();
  await new Future.delayed(new Duration(milliseconds: 100));
  createList();
}
