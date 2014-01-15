part of webpuzzle;

@NgController(
    selector: "[additional-info-ctrl]",
    publishAs: "additionalInfoCtrl"
)
class CreateAdditionalInfoCtrl {
  
  RouteProvider _routeProvider;

  CreateAdditionalInfoCtrl (Scope scope, RouteProvider this._routeProvider, WebComponentService webComponentService){
    
    scope['wc'] = {
      'githubLink': '${_routeProvider.parameters['user']}/${_routeProvider.parameters['repo']}',
      'name': '',
      'description': '',
      'imageLink': '',
      'demoLink': ''
    };
    
    scope['saveWc'] = (wc) {
      print("click");
      webComponentService.postWc(wc).then((data) => scope['data'] = data);
    };
  }

 }

