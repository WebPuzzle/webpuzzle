part of webpuzzle_spec;

class HttpTest extends Mock implements Http{}
class WsUrlTestWebComponentService extends Mock implements WsUrl{}
class WorldServiceTestWebComponentService extends Mock implements WorldService{}
class UserServiceTestWebComponentService extends Mock implements UserService{}

testWebComponentService(){
  group("[WebComponentService]", (){
    HttpTest http;
    WsUrl wsUrl;
    WorldService worldService;
    UserService userService;
    
    setUp((){
      http = new HttpTest();
      wsUrl = new WsUrlTestWebComponentService();
      worldService = new WorldServiceTestWebComponentService();
      userService = new UserServiceTestWebComponentService();
      
    });
    
    test("should initialize service", (){
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([{"name" : "a wc name"}])
          )
      );
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        expect(webComponentService.webcomponents.first["name"], equals("a wc name"));
      });
    });
    
    test("should select a current web component", (){
      
    });
    
    test("should deselect the current web component", (){
      
    });

  });
}