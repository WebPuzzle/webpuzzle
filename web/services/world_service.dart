part of webpuzzle;

@NgInjectableService()
class WorldService {
  
  static List<String> NICE_WORLDS_LIST = ['angularjs', 'angulardart', 'ember', 'jquery', 'polymer', 'polymerdart'];
  List<String> WORLDS_LIST = ['AngularJsWc', 'AngularDartWc', 'EmberWc', 'JqueryWc', 'PolymerJsWc', 'PolymerDartWc'];
  
  Router _router;
  String _world;
  RouteProvider _routeProvider;
  Scope _$root;
  
  /* 
    on stocke le monde au format WS 
  + on stocke le "nice world" dans le localStorage
  + on lance l'événement worldChanged
  */
  set world (String world) {
    switch (world) {
      case 'angularjs': _world = 'AngularJsWc'; break;
      case 'angulardart': _world = 'AngularDartWc'; break;
      case 'ember': _world = 'EmberWc'; break;
      case 'polymer': _world = 'PolymerJsWc'; break;
      case 'polymerdart': _world = 'PolymerDartWc'; break;
      case 'jquery': _world = 'JqueryWc'; break;
      default : _router.gotoUrl('/worlds');
    }
    window.localStorage['world'] = world;
    _$root.$broadcast("worldChanged");
  }
  
  get world {
    return _world;
  }
  
  WorldService(Router this._router, RouteProvider this._routeProvider, Scope scope) {
    _$root = scope.$root;
    if(window.localStorage['world'] !=null)
      world = window.localStorage['world'];
  }    
  

  String getNiceWorld() {
    switch (world) {
      case 'AngularJsWc': return 'angularjs'; break;
      case 'AngularDartWc': return 'angulardart'; break;
      case 'EmberWc': return 'ember'; break;
      case 'PolymerJsWc': return 'polymer'; break;
      case 'PolymerDartWc': return 'polymerdart'; break;
      case 'JqueryWc': return 'jquery'; break;
    }
  }
 
  
}