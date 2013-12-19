library webpuzzle;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:logging/logging.dart';
import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:utf/utf.dart';
import 'package:markdown/markdown.dart' as markdown;

part 'web_puzzle_route_initializer.dart';

part 'views/list_ctrl.dart';
part 'views/app_ctrl.dart';
part 'views/detail_ctrl.dart';
part 'views/create/create_github_ctrl.dart';
part 'views/create/create_additional_info_ctrl.dart';
part 'components/webcomponent_component.dart';
part 'services/github_service.dart';
part 'services/ws_url.dart';
part 'services/user_service.dart';
part 'views/auth_token_ctrl.dart';
part 'services/webcomponent_service.dart';
part 'directive/wp-dropdown-menu.dart';
part 'directive/wp-navbar-collapse.dart';
part 'directive/wp-tab.dart';
part 'components/readme_component.dart';

class WebPuzzleApp extends Module {
  WebPuzzleApp(){
    //controllers
    type(ListCtrl);
    type(AppCtrl);
    type(DetailCtrl);
    type(CreateGithubCtrl);
    type(CreateAdditionalInfoCtrl);
    type(AuthTokenCtrl);
    
    //components
    type(ReadmeComponent);
    type(WebcomponentComponent);
    type(WpDropdownMenu);
    type(WpNavbarCollapse);
    type(WpTab);
    
    //services
    type(UserService);
    type(WsUrl);
    type(WebComponentService);
    type(GithubService);
    
    type(RouteInitializer, implementedBy: WebPuzzleRouteInitializer);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
  }
}

main(){
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  ngBootstrap(module: new WebPuzzleApp());
}