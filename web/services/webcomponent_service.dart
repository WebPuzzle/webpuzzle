part of webpuzzle;

@NgInjectableService()
class WebComponentService {
  List webcomponents;
  var selectedWC;
  
  Future _whenDataIsLoaded;
  var _http;
  
  WebComponentService(Http this._http){
    _whenDataIsLoaded = _http(method: 'GET', url: 'webcomponents.json').then((HttpResponse response) {
      webcomponents = response.data;
      return webcomponents;
    });
  }
  
  Future dataInitialized(){
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