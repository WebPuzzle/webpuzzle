part of webpuzzle;

@NgController(
    selector: "[app-ctrl]",
    publishAs: "appCtrl"
)
class AppCtrl {
  
  
  
  String authentUrl;
  UserService userService;
  WebComponentService webComponentService;
  var user;


  AppCtrl (Scope scope, WsUrl ws_url, UserService this.userService, WebComponentService this.webComponentService){
    authentUrl = '${ws_url.webServiceUrl}/auth/github/send';
    user = userService.user;
  }
}

