library webpuzzle;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:logging/logging.dart';

part 'web_puzzle_route_initializer.dart';

part 'views/list_ctrl.dart';
part 'views/app_ctrl.dart';
part 'views/detail_ctrl.dart';
part 'views/create/create_github_ctrl.dart';
part 'views/create/create_additional_info_ctrl.dart';
part 'components/webcomponent_component.dart';
part 'services/selected_wc.dart';

class WebPuzzleApp extends Module {
  WebPuzzleApp(){
    type(ListCtrl);
    type(AppCtrl);
    type(DetailCtrl);
    type(WebcomponentComponent);
    type(SelectedWCService);
    type(CreateGithubCtrl);
    type(CreateAdditionalInfoCtrl);

    type(RouteInitializer, implementedBy: WebPuzzleRouteInitializer);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
  }
}

main(){
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  ngBootstrap(module: new WebPuzzleApp());
}