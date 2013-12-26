part of webpuzzle_spec;

class RouterTestList extends TestDouble implements Router{}
class ScopeTestList extends TestDouble implements Scope{}
class WebComponentServiceTestList extends TestDouble implements WebComponentService{}
class WorldServiceTestList extends TestDouble implements WorldService{}


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
      
      worldService.stub("onChangeWorld");
      scope.stub(r"$watch");
      router.stub("get hoy").andReturn("bonjour");
      //setting name directly is a workaround because 
      //name property exists in TestDouble class
      router.stub("get activePath").andReturn(new List()
        ..add(new TestDouble()..name = "list"));
      router.stub("get onRouteStart").andReturn(new TestDouble()..stub("listen"));
      webComponentService.stub("load").andReturn(new Future.value(
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

    test("should initialize contorller", (){
      worldService.shouldReceive("onChangeWorld");
      scope.shouldReceive(r"$watch").times(2);
      webComponentService.shouldReceive("load");
      listCtrl.loadData().then((value){
        expect(listCtrl.webcomponents.length, equals(2));
      });
      print("activePath.first ${router.activePath.first.name}");
      expect(listCtrl.viewMode, equals("list"));
      router.shouldReceive("get onRouteStart");
      expect(listCtrl.sortingTypes.length, equals(4));
      expect(listCtrl.filterTypes.length, equals(2));
    });
  });
}