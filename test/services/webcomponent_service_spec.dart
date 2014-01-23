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
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([
                  {"name" : "a wc name", "selected" : false},
                  {"name" : "another wc", "selected" : false},
                  {"name" : " yet another wc", "selected" : false}
                  ])
          )
      );
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        webComponentService.selectCurrentWebComponent(webComponentService.webcomponents.first);
        expect(webComponentService.webcomponents.first["selected"], isTrue);
        expect(webComponentService.webcomponents[1]["selected"], isFalse);
        expect(webComponentService.webcomponents[2]["selected"], isFalse);
        expect(identical(webComponentService.selectedWC, webComponentService.webcomponents.first), isTrue);
      });
    });
    
    test("should change the currently selected web component", (){
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([
                  {"name" : "a wc name", "selected" : false},
                  {"name" : "another wc", "selected" : true},
                  {"name" : " yet another wc", "selected" : false}
                  ])
          )
      ); 
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        webComponentService.selectCurrentWebComponent(webComponentService.webcomponents.first);
        expect(webComponentService.webcomponents.first["selected"], isTrue);
        expect(webComponentService.webcomponents[1]["selected"], isFalse);
        expect(webComponentService.webcomponents[2]["selected"], isFalse);
        expect(identical(webComponentService.selectedWC, webComponentService.webcomponents.first), isTrue);
      });
    });
    
    test("should select a current web component based on an id", (){
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([
                  {"name" : "a wc name", "selected" : false, "id" : 2},
                  {"name" : "another wc", "selected" : true, "id" : 10},
                  {"name" : " yet another wc", "selected" : false, "id" : 12}
                  ])
          ) 
      );
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        webComponentService.selectCurrentWebComponentById(12);
        expect(webComponentService.webcomponents.first["selected"], isFalse);
        expect(webComponentService.webcomponents[1]["selected"], isFalse);
        expect(webComponentService.webcomponents[2]["selected"], isTrue);
        expect(identical(webComponentService.selectedWC, webComponentService.webcomponents[2]), isTrue);
      });
    }); 

    test("should deselect the current selected web component", (){ 
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([
                  {"name" : "a wc name", "selected" : false},
                  {"name" : "another wc", "selected" : true},
                  {"name" : " yet another wc", "selected" : false}
                  ]) 
          ) 
      );
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        webComponentService.deselectCurrentWebComponent();
        expect(webComponentService.webcomponents.first["selected"], isFalse);
        expect(webComponentService.webcomponents[1]["selected"], isFalse);
        expect(webComponentService.webcomponents[2]["selected"], isFalse);
      });
    });

    test("should POST a given web component", (){
      http.when(callsTo("call")).thenReturn(
          new Future.value(
              new Mock()
                ..when(callsTo("get data")).thenReturn([{"name" : "a wc name"}])
          )
      ).thenReturn(new Future.value("response"));
      
      WebComponentService webComponentService = new WebComponentService(http, wsUrl, worldService, userService);
      webComponentService.dataInitialized().then((d){
        webComponentService.postWc(webComponentService.webcomponents.first);
        http.getLogs(callsTo("call")).verify(happenedAtMost(2));
      });
    });
    
  });
}