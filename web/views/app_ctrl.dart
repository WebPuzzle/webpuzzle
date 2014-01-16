part of webpuzzle;

@NgController(
    selector: "[app-ctrl]",
    publishAs: "appCtrl"
)
class AppCtrl {
  
  String authentUrl;
  UserService userService;
  WebComponentService webComponentService;
  RouteProvider _routeProvider;
  WorldService _worldService;
  var user;
  Router _router;


  AppCtrl (Scope scope,RouteProvider this._routeProvider, Router this._router, WsUrl ws_url, UserService this.userService, WebComponentService this.webComponentService, WorldService this._worldService){
    authentUrl = '${ws_url.webServiceUrl}/auth/github/send';
    user = userService.user;
    _worldService.world = _routeProvider.parameters["world"];
    print("2 - World service : world = ${_routeProvider.parameters["world"]}");
    print("active path ${_router.activePath.first.name}");
    
    scope['world'] = _worldService.getNiceWorld();
    
  }
}

