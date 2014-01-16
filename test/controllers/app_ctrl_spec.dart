part of webpuzzle_spec;

class ScopeTestApp extends Mock implements Scope { 
  Map map = new Map();
  operator []=(K key, V value) {
    map[key] = value;
  }
  operator [] (K key) => map[key];
}
class RouteProviderTestApp extends Mock implements RouteProvider {
  Map parameters = {"world" : "a world"};
}
class RouterTestApp extends Mock implements Router {}
class WsUrlTestApp extends Mock implements WsUrl{ var webServiceUrl = "url";}
class UserServiceTestApp extends Mock implements UserService{ var user = "user";}
class WebComponentServiceTestApp extends Mock implements WebComponentService{}
class WorldServiceTestApp extends Mock implements WorldService{}

testAppCtrl(){
  group("[AppCtrl]", (){
    Scope scope;
    RouteProvider routeProvider;
    Router router;
    WsUrl wsUrl;
    UserService userService;
    WebComponentService webComponentService;
    WorldService worldService;
 
    setUp((){
      scope = new ScopeTestApp();
      routeProvider = new RouteProviderTestApp();
      router = new RouterTestApp();
      wsUrl = new WsUrlTestApp();
      userService = new UserServiceTestApp();
      webComponentService = new WebComponentServiceTestApp();
      worldService = new WorldServiceTestApp();
    });

    test("storing the call", (){
      worldService.when(callsTo("getNiceWorld")).thenReturn("a world");
      router.when(callsTo("get activePath")).thenReturn(
          new Mock()..when(callsTo("get first")).thenReturn(
              new PathMock()..name = "a path name"));
      final appCtrl = new AppCtrl(scope, routeProvider, router, wsUrl, 
          userService, webComponentService, worldService);
      expect(appCtrl.user, equals("user"));
      expect(appCtrl.authentUrl, equals("url/auth/github/send"));
      expect(scope['world'], equals("a world"));
    });
  });
}