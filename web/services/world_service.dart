part of webpuzzle;

@NgInjectableService()
class WorldService {
  
  static List<String> NICE_WORLDS_LIST = ['angularjs', 'angulardart', 'ember', 'jquery', 'polymer', 'polymerdart'];
  List<String> WORLDS_LIST = ['AngularJsWc', 'AngularDartWc', 'EmberWc', 'JqueryWc', 'PolymerJsWc', 'PolymerDartWc'];
  
  Router _router;
  String _world;
  List<Function> _onChangeWorldCallbacks;
  
  set world (String world) {
    switch (world) {
      case 'angularjs': _world = 'AngularJsWc'; break;
      case 'angulardart': _world = 'AngularDartWc'; break;
      case 'ember': _world = 'EmberWc'; break;
      case 'polymer': _world = 'PolymerJsWc'; break;
      case 'polymerdart': _world = 'PolymerDartWc'; break;
      case 'jquery': _world = 'JqueryWc'; break;
    }
    triggerWorldChange();
  }
  
  get world {
    return _world;
  }
  
  WorldService(Router this._router) {
    _onChangeWorldCallbacks = new List();
    // regexp to obtain the world
    RegExp regExp = new RegExp(r'app/(.*?)/.*');
    String location = window.location.href.toString();
    if (!regExp.hasMatch(location)) {
      _router.gotoUrl('/worlds');   
    } else {
      var matches = regExp.allMatches(location);
      var match = matches.first;
      world = match.group(1);
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
 
  
  checkWorld() {
    // verify if the world is contained in the world list
    if (!WORLDS_LIST.contains(world)) {
      Logger.root.warning("World is not valid");
      _router.gotoUrl('/worlds');
    }
        
  }
  
}