part of webpuzzle;

@NgController(
    selector: "[app-ctrl]",
    publishAs: "appCtrl"
)
class AppCtrl {
  
  String authentUrl;

  AppCtrl (Scope scope, WsUrl _ws_url){
    authentUrl = _ws_url.webServiceUrl;
  }
}

