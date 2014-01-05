part of webpuzzle;

@NgInjectableService()
class WebComponentService {
  List webcomponents;
  var selectedWC;
  
  Future _whenDataIsLoaded;
  var _http;
  var _wsUrl;
  var _worldService;
  
  WebComponentService(Http this._http, WsUrl this._wsUrl, WorldService this._worldService){
    load();
  }
  
  Future dataInitialized(){
    return _whenDataIsLoaded;
  }
  
  load() {
    _whenDataIsLoaded = _http(method: 'GET', url: "${_wsUrl.webServiceUrl}/web_components/${_worldService.world}.json").then((HttpResponse response) {
      webcomponents = response.data;
      return webcomponents;
    });
    return _whenDataIsLoaded;
  }
  
  void selectCurrentWebComponent(wc){
    if (selectedWC != null){
      selectedWC['selected'] = false;
    }
    selectedWC = wc;
    selectedWC['selected'] = true;
  }
  
  void selectCurrentWebComponentFromId(int id){
    selectCurrentWebComponent(webcomponents.firstWhere((wc) => wc['id'] == id));
  }
  
  void deselectCurrentWebComponent(){
    webcomponents.forEach((wc){
      if (wc['selected'] == true) wc['selected'] = false;
    });
  }
}