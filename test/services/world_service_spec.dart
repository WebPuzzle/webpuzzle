part of webpuzzle_spec;

class RouterTestWorldService extends Mock implements Router{}
class RouteProviderTestWorldService extends Mock implements RouteProvider{}

testWorldService() {
  group("[WorldService]", (){
    Router router;
    RouteProvider routeProvider;
    
    setUp( () {
      router = new RouterTestWorldService();
      routeProvider = new RouteProviderTestWorldService();
      html.window.localStorage.clear();
    });
    
    test("should initialize world_service without world", () {
      WorldService worldService = new WorldService(router, routeProvider);
      expect(worldService.world, isNull);
    });
    
    test("should initialize world_service with a world", () {
      html.window.localStorage['world'] = "angularjs";
      WorldService worldService = new WorldService(router, routeProvider);
      expect(worldService.world, "AngularJsW");
    });
    
  });
}