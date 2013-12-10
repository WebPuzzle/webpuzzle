library talk_to_me;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';

part 'web_puzzle_route_initializer.dart';

part 'models/call.dart';
part 'models/agenda_item.dart';
part 'views/list_ctrl.dart';
part 'views/create_call_ctrl.dart';

class TalkToMeApp extends Module {
  TalkToMeApp(){
    type(ListCtrl);
    type(CreateCtrl);

    type(RouteInitializer, implementedBy: WebPuzzleRouteInitializer);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
  }
}

main(){

  ngBootstrap(module: new TalkToMeApp());
}