part of webpuzzle_spec;

class RouterTestList extends Mock implements Router{}
class ScopeTestList extends Mock implements Scope{}
class WebComponentServiceTestList extends Mock implements WebComponentService{}
class WorldServiceTestList extends Mock implements WorldService{}

//workaround because name property can't be mocked
class PathMock {
  Mock mock = new Mock();
  
  String name;
  
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
      ..add(new PathMock()..name = "list"));
      router.when(callsTo("get onRouteStart")).thenReturn(new Mock()
      ..when(callsTo("listen")).thenReturn(null));
      
      webComponentService.when(callsTo("loadWc")).alwaysReturn(new Future.value(
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
      scope.getLogs(callsTo(r"$on")).verify(happenedOnce);
      scope.getLogs(callsTo(r"$watch")).verify(happenedExactly(2));
      webComponentService.getLogs(callsTo("loadWc")).verify(happenedExactly(2));
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
      listCtrl.selectSortingType(listCtrl.sortingTypes.first);
      expect(listCtrl.sortingTypes.first['selected'], isTrue);
      expect(listCtrl.sortingTypes[1]['selected'], isFalse);
    });
    
    test("should select filter type", (){
      listCtrl.selectFilterType(listCtrl.filterTypes.first);
      expect(listCtrl.filterTypes.first['selected'], isTrue);
      expect(listCtrl.filterTypes[1]['selected'], isFalse);
    });
  });
  
}