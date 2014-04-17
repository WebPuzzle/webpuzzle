part of webpuzzle_spec;

class UserServiceTestAuthToken extends Mock implements UserService {}
class RouteProviderTestAuthToken extends Mock implements RouteProvider {}
class RouterTestAuthToken extends Mock implements Router {}

testAuthTokenCtrl() {
  group("[AuthTokenCtrl]", () {
    UserServiceTestAuthToken userService;
    RouteProviderTestAuthToken routeProvider;
    RouterTestAuthToken router;
    AuthTokenCtrl authTokenCtrl;

    setUp(() {
      userService = new UserServiceTestAuthToken();
      routeProvider = new RouteProviderTestAuthToken();
      router = new RouterTestAuthToken();

      //Setting up mocks
      userService.when(callsTo("checkToken")).thenReturn(
          new Mock()..when(callsTo("then")).thenReturn(null));
      userService.when(callsTo("setToken")).thenReturn(null);
      userService.when(callsTo("setUserInfo")).thenReturn(null);
      userService.when(callsTo("updateUserInfo")).thenReturn(null);
      routeProvider.when(callsTo("get parameters")).alwaysReturn({"finalToken": "token"});
      router.when(callsTo("gotoUrl")).thenReturn(null);
    });

    /**
     *Should use UserService and check token found in the route parameters
     */
    test("should initialize AuthToken controller", () {
      authTokenCtrl = new AuthTokenCtrl(userService, routeProvider, router);
      userService.getLogs(callsTo("checkToken", "token")).verify(happenedOnce);
    });

    test("should handle checkToken success", (){
      authTokenCtrl = new AuthTokenCtrl(userService, routeProvider, router);
      var responseMock = new Mock()..when(callsTo("get data")).alwaysReturn({"key":"value"});
      authTokenCtrl.checkTokenSuccess(responseMock);
      userService.getLogs(callsTo("setToken", "token")).verify(happenedOnce);
      userService.getLogs(callsTo("setUserInfo", "{\"key\":\"value\"}")).verify(happenedOnce);
      userService.getLogs(callsTo("updateUserInfo")).verify(happenedOnce);
      router.getLogs(callsTo("gotoUrl", "/app/list")).verify(happenedOnce);
    });
  });
}