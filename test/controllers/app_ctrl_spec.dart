part of webpuzzle_spec;

class TestWsUrl extends TestDouble implements WsUrl{ var webServiceUrl = "url";}
class TestUserService extends TestDouble implements UserService{ var user = "user";}
class TestWebComponentService extends TestDouble implements WebComponentService{}

testAppCtrl(){
  group("[AppCtrl]", (){
    var wsUrl, userService, webComponentService;

    setUp((){
      wsUrl = new TestWsUrl();
      userService = new TestUserService();
      webComponentService = new TestWebComponentService();
    }); 

    test("storing the call", (){
      final appCtrl = new AppCtrl(wsUrl, userService, webComponentService);
      expect(appCtrl.user, equals("user"));
      expect(appCtrl.authentUrl, equals("url/auth/github/send"));
    });
  });
}