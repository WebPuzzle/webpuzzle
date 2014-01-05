part of webpuzzle_spec;

class WsUrlTestApp extends TestDouble implements WsUrl{ var webServiceUrl = "url";}
class UserServiceTestApp extends TestDouble implements UserService{ var user = "user";}
class WebComponentServiceTestApp extends TestDouble implements WebComponentService{}

testAppCtrl(){
  group("[AppCtrl]", (){
    var wsUrl, userService, webComponentService;

    setUp((){
      wsUrl = new WsUrlTestApp();
      userService = new UserServiceTestApp();
      webComponentService = new WebComponentServiceTestApp();
    }); 

    test("storing the call", (){
      final appCtrl = new AppCtrl(wsUrl, userService, webComponentService);
      expect(appCtrl.user, equals("user"));
      expect(appCtrl.authentUrl, equals("url/auth/github/send"));
    });
  });
}