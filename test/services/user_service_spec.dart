part of webpuzzle_spec;

class HttpTestUserService extends Mock implements Http{}
class WsUrlTestUserService extends Mock implements WsUrl{}

var window = html.window;

testUserService(){
  group("[UserService]", (){
    HttpTestUserService http;
    WsUrlTestUserService wsUrl;

    setUp((){
      http = new HttpTest();
      wsUrl = new WsUrlTestUserService();
      window.localStorage.clear();
    });

    tearDown((){
      window.localStorage.clear();
    });

    /**
     * It should initialize UserService
     * user info should be read from localstorage
     */
    test("should initialize User Service", (){
      window.localStorage['github-user-info'] = '{"info": "test"}';
      UserService userService = new UserService(http, wsUrl);
      expect(userService.user, equals({"info": "test"}));
    });

    /**
     * Setting user info in local storage should come out
     * the same
     */
    test("should set user info", (){
      UserService userService = new UserService(http, wsUrl);
      userService.setUserInfo("test info");
      expect(userService.getUserInfo(), equals("test info"));
    });

    /**
     * Getting a string token from local storage
     * should work and come out as the same String
     */
    test("should get github token", (){
      String token = 'a token 123';
      window.localStorage['github-token'] = token;
      UserService userService = new UserService(http, wsUrl);
      expect(userService.getToken(), equals(token));
    });

    /**
     * Setting a github token should store it in local storage
     */
    test("should set a token in localstorage", (){
      String token = "a token 123";
      UserService userService = new UserService(http, wsUrl);
      userService.setToken(token);
      expect(window.localStorage['github-token'], equals(token));
    });

    test("should check github token, calling http", (){
      http.when(callsTo("call")).thenReturn(null);
      wsUrl.when(callsTo("get webServiceUrl")).thenReturn("url");
      UserService userService = new UserService(http, wsUrl);
      userService.checkToken('token');
      http.getLogs(callsTo("call")).verify(happenedOnce);
    });

    /**
     * Should sign the user, by setting its data in localstorage
     * This simply calls setUserInfo atm (maybe it should be removed ?)
     */
    test("should sign in", (){
      UserService userService = new UserService(http, wsUrl);
      userService.signIn("test info");
      expect(userService.getUserInfo(), equals("test info"));
    });

    /**
     * Should Sign out, by clearing localStorage
     * Any user info previously set should be emptied
     */
    test("should sign out", (){
      UserService userService = new UserService(http, wsUrl);
      userService.setUserInfo("test info");
      userService.signOut();
      expect(userService.getUserInfo(), equals(null));
    });

  });
}