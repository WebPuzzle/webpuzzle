part of webpuzzle;

@NgController(
    selector: "[additional-info-ctrl]",
    publishAs: "additionalInfoCtrl"
)
class CreateAdditionalInfoCtrl {
  
  RouteProvider _routeProvider;
  var _wsUrl;
  var _githubService;

  CreateAdditionalInfoCtrl (Scope scope, RouteProvider this._routeProvider, WebComponentService webComponentService, WsUrl this._wsUrl, GithubService this._githubService){
    
    scope['wc'] = {
      'githubLink': '${_routeProvider.parameters['user']}/${_routeProvider.parameters['repo']}',
      'name': '',
      'description': '',
      'imageLink': '',
      'demoLink': '',
      'imageId':'',
      'author':_routeProvider.parameters['user']
    };
    
    scope['saveWc'] = (wc) {
      print("click");      
      webComponentService.postWc(wc).then((data) => scope['data'] = data);
    };
  }

 }

