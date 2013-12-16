library webpuzzle;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:logging/logging.dart';
import 'dart:async';
import 'dart:html';
import 'dart:convert';

part 'web_puzzle_route_initializer.dart';

part 'views/list_ctrl.dart';
part 'views/app_ctrl.dart';
part 'views/detail_ctrl.dart';
part 'views/create/create_github_ctrl.dart';
part 'views/create/create_additional_info_ctrl.dart';
part 'components/webcomponent_component.dart';
part 'services/selected_wc.dart';
part 'services/github_service.dart';
part 'services/ws_url.dart';
part 'services/user_service.dart';
part 'views/auth_token_ctrl.dart';
part 'services/webcomponent_service.dart';


class WebPuzzleApp extends Module {
  WebPuzzleApp(){
    type(ListCtrl);
    type(AppCtrl);
    type(DetailCtrl);
    type(WebcomponentComponent);
    type(WebComponentService);
    type(CreateGithubCtrl);
    type(CreateAdditionalInfoCtrl);
    type(UserService);
    type(WsUrl);
    type(AuthTokenCtrl);

    type(RouteInitializer, implementedBy: WebPuzzleRouteInitializer);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
  }
}

main(){
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  ngBootstrap(module: new WebPuzzleApp());
}