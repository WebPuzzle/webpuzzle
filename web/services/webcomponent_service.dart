part of webpuzzle;

@NgInjectableService()
class WebComponentService {
  List webcomponents;
  var selectedWC;
  
  Future _whenDataIsLoaded;
  var _http;
  var _wsUrl;
  var _worldService;
  UserService _userService;
  
  WebComponentService(Http this._http, WsUrl this._wsUrl, WorldService this._worldService, UserService this._userService){
    loadWc();
  }
  
  Future dataInitialized(){
    return _whenDataIsLoaded;
  }
  
  loadWc() {
    _whenDataIsLoaded = _http(method: 'GET', 
        url: "${_wsUrl.webServiceUrl}/web_components/${_worldService.world}.json").then((HttpResponse response) {
      webcomponents = response.data;
      return webcomponents;
    });
    return _whenDataIsLoaded;
  }
  
  void selectCurrentWebComponent(wc){
    deselectCurrentWebComponent();
    selectedWC = wc;
    selectedWC['selected'] = true;
    webcomponents.forEach((awc){print("awc : ${awc}");});
  }
  
  void selectCurrentWebComponentById(int id){
    selectCurrentWebComponent(webcomponents.firstWhere((wc) => wc['id'] == id));
  }
  
  void deselectCurrentWebComponent(){
    webcomponents.forEach((wc){
      wc['selected'] = false;
    });
  }
  
  Future<HttpResponse> postWc(webComponent) {
    return _http(method: 'POST', url:'${_wsUrl.webServiceUrl}/web_component/${_worldService.world}.json', 
        data:webComponent, params:{'auth_token': _userService.getToken()}).then((HttpResponse response) {
      return response.data;
    }).catchError((e){
      print(e);
    });
  }
  
}