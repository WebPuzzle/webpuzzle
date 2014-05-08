part of webpuzzle_spec;

class RouterTestWorldService extends Mock implements Router{}
class RouteProviderTestWorldService extends Mock implements RouteProvider{}
class ScopeTestWorldService extends Mock implements Scope{}

testWorldService() {
  group("[WorldService]", (){
    RouterTestWorldService router;
    RouteProviderTestWorldService routeProvider;
    ScopeTestWorldService scope;
    
    setUp( () {
      router = new RouterTestWorldService();
      routeProvider = new RouteProviderTestWorldService();
      scope = new ScopeTestWorldService();
      scope.when(callsTo(r"get rootScope")).thenReturn(new ScopeTestWorldService(), 2);
      html.window.localStorage.clear();
    });
    
    test("should initialize world_service without world", () {
      WorldService worldService = new WorldService(router, routeProvider, scope);
      expect(worldService.world, isNull);
      scope.rootScope.getLogs(callsTo(r"broadcast")).verify(happenedExactly(0));
    });
    
    test("should initialize world_service with a world", () {
      html.window.localStorage['world'] = "angularjs";
      scope.rootScope.when(callsTo(r"broadcast")).thenReturn(null, 1);
      WorldService worldService = new WorldService(router, routeProvider, scope);
      expect(worldService.world, "AngularJsWc");
    });
    
    test("should set world", () {
      scope.rootScope.when(callsTo(r"broadcast")).thenReturn(null, 1);
      WorldService worldService = new WorldService(router, routeProvider, scope);
      worldService.world = "angularjs";
      expect(worldService.world, "AngularJsWc");
      expect(html.window.localStorage['world'], "angularjs");
    });
    
    
    test("should redirect the user", () {
      html.window.localStorage['world'] = "fakeWorld";
      router.when(callsTo("gotoUrl")).thenReturn(null);
      scope.rootScope.when(callsTo(r"broadcast")).thenReturn(null, 1);
      WorldService worldService = new WorldService(router, routeProvider, scope);
      router.getLogs(callsTo("gotoUrl")).verify(happenedOnce);
    });
    
  });
}