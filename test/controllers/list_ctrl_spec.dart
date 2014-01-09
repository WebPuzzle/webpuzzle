part of webpuzzle_spec;

class RouterTestList extends Mock implements Router{}
class ScopeTestList extends Mock implements Scope{}
class WebComponentServiceTestList extends Mock implements WebComponentService{}
class WorldServiceTestList extends Mock implements WorldService{}

//workaround because name property can't be mocked
class PathMock {
  Mock mock = new Mock();
  
  noSuchMethod(Invocation invocation) {
    return mock.noSuchMethod(invocation);
  }
}

testListCtrl(){
  group("[ListCtrl]", (){
    RouterTestList router;
    ScopeTestList scope; 
    WebComponentServiceTestList webComponentService;
    WorldServiceTestList worldService;
    ListCtrl listCtrl;
    
    setUp((){
      router = new RouterTestList();
      scope = new ScopeTestList();
      webComponentService = new WebComponentServiceTestList();
      worldService = new WorldServiceTestList();
      
      worldService.when(callsTo("onChangeWorld")).thenReturn(null);
      scope.when(callsTo(r"$watch")).thenReturn(null, 2);
      //setting name directly is a workaround because 
      //name property exists in TestDouble class 
      router.when(callsTo("get activePath")).alwaysReturn(new List()
      ..add(new PathMock()..mock.when(callsTo("get name")).alwaysReturn("list")));
      router.when(callsTo("get onRouteStart")).thenReturn(new Mock()..when(callsTo("listen")).thenReturn(null));
      
      webComponentService.when(callsTo("load")).alwaysReturn(new Future.value(
        [{
           "author": null, "demoLink": null, "description": "I display awesome cats",
           "githubLink": "https://github.com/Benoit-Vasseur/WebPuzzle-Front", "id": 4,
            "imageLink": "photo.jpg",
           "name": "catComponent", "submitter": { "id": 1, "name": "florrain"}
         },{
           "author": null, "demoLink": null, "description": "I display cats",
           "githubLink": "https://github.com/Benoit-Vasseur/WebPuzzle-Front","id": 5, 
           "imageLink": "photo.jpeg",
           "name": "catComponentPremium", "submitter": {"id": 1, "name": "florrain"}
         }]
      ));
      
      listCtrl = new ListCtrl(router, scope, webComponentService, worldService);
    }); 

    test("should initialize controller", (){
      worldService.getLogs(callsTo("onChangeWorld")).verify(happenedOnce);
      scope.getLogs(callsTo(r"$watch")).verify(happenedExactly(2));
      webComponentService.getLogs(callsTo("load")).verify(happenedOnce);
      listCtrl.loadData().then((value){
        expect(listCtrl.webcomponents.length, equals(2));
      });
      print("activePath.first ${router.activePath.first.name}");
      expect(listCtrl.viewMode, equals("list"));
      router.getLogs(callsTo("get onRouteStart")).verify(happenedOnce);
      expect(listCtrl.sortingTypes.length, equals(4));
      expect(listCtrl.filterTypes.length, equals(2));
    });
    
    test("should select sorting type", (){
      
    }
  });
  
}