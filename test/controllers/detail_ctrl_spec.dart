part of webpuzzle_spec;
class RouteProviderTestDetail extends Mock implements RouteProvider{ 
  var parameters = {"id" : "2"};}
class WebComponentServiceTestDetail extends Mock implements WebComponentService{
  var selectedWC;
}
class WorldServiceTestDetail extends Mock implements WorldService{}

testDetailCtrl() {
  group("[DetailCtrl", (){
    RouteProvider routeProvider;
    WebComponentService webComponentService;
    WorldService worldService;
    
    setUp((){ 
      routeProvider = new RouteProviderTestDetail();
      webComponentService = new WebComponentServiceTestDetail();
      worldService = new WorldServiceTestDetail();
    });
    
    test("should initialize with a selectedWC in WCService", (){
      webComponentService.selectedWC = {"name" : "I am a fake wc"};
      DetailCtrl detailCtrl = new DetailCtrl(routeProvider, webComponentService, worldService);
      expect(detailCtrl.selectedWC["name"], equals("I am a fake wc"));
    });
    

    test("should initialize without a selectedWC in WCService", (){
      webComponentService.when(callsTo("dataInitialized")).thenReturn(new Future.value(null));
      webComponentService.when(callsTo("selectCurrentWebComponentFromId"))
        .thenCall((int id) => webComponentService.selectedWC = {"name" : "I am a fake wc"});
      DetailCtrl detailCtrl = new DetailCtrl(routeProvider, webComponentService, worldService);
      webComponentService.getLogs(callsTo("dataInitialized")).verify(happenedOnce);
      detailCtrl.testControllerInitializedAsync.then((d){
        expect(detailCtrl.selectedWC["name"], equals("I am a fake wc"));
      });
    });
    
    test("should set up jsfiddle demo", (){
      webComponentService.selectedWC = {"demoLink" : "http://jsfiddle.net/jgoemat/kta95/"};
      DetailCtrl detailCtrl = new DetailCtrl(routeProvider, webComponentService, worldService);
      expect(webComponentService.selectedWC["demoLinkUrl"], equals("http://jsfiddle.net/jgoemat/kta95/embedded/result,js,html,css/"));
    });
    
    test("should set up codepen demo", (){
      webComponentService.selectedWC = {"demoLink" : "http://codepen.io/bradleybossard/pen/KoyAa"};
      DetailCtrl detailCtrl = new DetailCtrl(routeProvider, webComponentService, worldService);
      expect(webComponentService.selectedWC["codePen"]["user"], equals("bradleybossard"));
      expect(webComponentService.selectedWC["codePen"]["slugHash"], equals("KoyAa"));
    });
    
  });

}//"http://codepen.io/bradleybossard/pen/KoyAa"