part of webpuzzle_spec;

class WorldServiceTestWorlds extends Mock implements Scope {}
class ScopeTestWorlds extends Mock implements Scope {}
class RouterTestWorlds extends Mock implements Router {}

testWorldsCtrl() {
  group("[WorldsCtrl]", () {
    RouterTestWorlds router;
    ScopeTestWorlds scope;
    WorldServiceTestWorlds worldService;
    WorldsCtrl worldsCtrl;

    setUp(() {
      router = new RouterTestWorlds();
      scope = new ScopeTestWorlds();
      worldService = new WorldServiceTestWorlds();
    });

    /**
     * Having something on the world property should cause a redirect
     */
    test("should initialize worlds controller", () {
      worldService.when(callsTo("get world")).thenReturn("something");
      worldService.when(callsTo("getNiceWorld")).thenReturn("polymer");

      worldsCtrl = new WorldsCtrl(worldService, scope, router);
      router.getLogs(callsTo('go', 'app', {"world": "polymer"}))
        .verify(happenedExactly(1));
    });

  });
}