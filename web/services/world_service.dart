part of webpuzzle;

@NgInjectableService()
class WorldService {
  
  static List<String> NICE_WORLDS_LIST = ['angularjs', 'angulardart', 'ember', 'jquery', 'polymer', 'polymerdart'];
  List<String> WORLDS_LIST = ['AngularJsWc', 'AngularDartWc', 'EmberWc', 'JqueryWc', 'PolymerJsWc', 'PolymerDartWc'];
  
  Router _router;
  String _world;
  RouteProvider _routeProvider;
  List<Function> _onChangeWorldCallbacks;
  
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
    triggerWorldChange();
  }
  
  get world {
    return _world;
  }
  
  WorldService(Router this._router, RouteProvider this._routeProvider) {
    _onChangeWorldCallbacks = new List();
    
  }    
  
// regexp to obtain the world
  String getCurrentWorld() {
    try {
      String world = _routeProvider.parameters["world"];
      return world;
    } catch (ex) {
      return null;
    }
    
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
  
  void triggerWorldChange() {
    _onChangeWorldCallbacks.forEach((Function callback) => callback());
  }
  
  void onChangeWorld(Function callbackFunction) {
    _onChangeWorldCallbacks.add(callbackFunction);
  }
  
  void removeOnChangeWorldCallback(Function callbackFunction) {
    _onChangeWorldCallbacks.remove(callbackFunction);
  }
 
  
}