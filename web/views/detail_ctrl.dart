part of webpuzzle;

@NgController(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  var currentId;
  var selectedWCService;
  var selectedWC;
  
  DetailCtrl (RouteProvider routeProvider ,SelectedWCService this.selectedWCService, Http http){
    selectedWC = selectedWCService.selectedWC;
    currentId = routeProvider.parameters["id"];
    
    if (selectedWC == null){
      http.get('http://webpuzzlews.herokuapp.com/web_components/$currentId.json').then((HttpResponse response) {
      selectedWCService.selectedWC = response.data;
      selectedWC = response.data;
      print("No selectedWC in memory, got data from WS");
    });
    }
  }
  
}

