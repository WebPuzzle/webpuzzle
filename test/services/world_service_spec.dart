part of webpuzzle_spec;

class RouterTestWorldService extends Mock implements Router{}
class RouteProviderTestWorldService extends Mock implements RouteProvider{}

testWorldService() {
  group("[WorldService]", (){
    RouterTestWorldService router;
    RouteProviderTestWorldService routeProvider;
    
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
      expect(worldService.world, "AngularJsWc");
    });
    
    test("should redirect the user", () {
      html.window.localStorage['world'] = "fakeWorld";
      router.when(callsTo("gotoUrl")).thenReturn(null);
      WorldService worldService = new WorldService(router, routeProvider);
      router.getLogs(callsTo("gotoUrl")).verify(happenedOnce);
    });
    
  });
}