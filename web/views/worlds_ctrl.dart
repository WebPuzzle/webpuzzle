part of webpuzzle;

@NgController (
    selector: '[worlds-ctrl]',
    publishAs: 'worldsCtrl'
)
class WorldsCtrl {
  
 
  
  WorldService worldService;
  Scope _rootScope;
  
  WorldsCtrl(WorldService this.worldService, Scope scope) {
    _rootScope = scope.$root;
   
  }
   
}