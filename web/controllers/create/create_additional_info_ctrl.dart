part of webpuzzle;

@NgController(
    selector: "[additional-info-ctrl]",
    publishAs: "additionalInfoCtrl"
)
class CreateAdditionalInfoCtrl {
  
  RouteProvider _routeProvider;
  Router _router;
  var _wsUrl;
  var _githubService;

  CreateAdditionalInfoCtrl (Scope scope, RouteProvider this._routeProvider, Router this._router, WebComponentService webComponentService, WsUrl this._wsUrl, GithubService this._githubService, WorldService worldService ){
    
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
      webComponentService.postWc(wc).then((data) => _router.go('app', {"world": worldService.getNiceWorld()}));
    };
    
    scope['goBack'] = () {
      _router.go('app.create.github', {"world": worldService.getNiceWorld()});                 
    };
  }

 }

