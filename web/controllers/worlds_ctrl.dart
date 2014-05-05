part of webpuzzle;

@Controller (
    selector: '[worlds-ctrl]',
    publishAs: 'worldsCtrl'
)
class WorldsCtrl {

  WorldService worldService;
  //Scope _rootScope;
  
  WorldsCtrl(WorldService this.worldService, Scope scope, Router router) {
    if(worldService.world != null) {
      print("world redirection");
      router.go('app',{"world": worldService.getNiceWorld()});
    }
  }
   
}