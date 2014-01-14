part of webpuzzle;

@NgController(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  int currentId;
  WebComponentService webComponentService;
  WorldService worldService;
  var selectedWC;
  
  DetailCtrl (RouteProvider routeProvider , WebComponentService this.webComponentService, WorldService this.worldService){
    selectedWC = webComponentService.selectedWC;
    currentId = int.parse(routeProvider.parameters["id"]);
    print("selectedWC : $selectedWC");
    if (selectedWC == null){
      webComponentService.dataInitialized().then((dynamic) {
        webComponentService.selectCurrentWebComponentFromId(currentId);
        selectedWC = webComponentService.selectedWC;
        setUpDemo(selectedWC);
        print("No selectedWC in memory, using url parameter 'id'");
      });
    }else {
      setUpDemo(selectedWC);
    }
  }

  setUpDemo(selectedWC){    
    if (selectedWC != null){
      _extractDemoType(selectedWC['demoLink']);
      if (selectedWC['demoType'] == 'codepen'){
        _setUpCodePenData(selectedWC['demoLink']);
      }
      if (selectedWC['demoType'] == 'jsfiddle'){
        _setUpJsFiddleData(selectedWC['demoLink']);
      }
    }else {
      print("cannot setUpDemo, selectedWC is null");
    }
  }

  _extractDemoType(demoLink){
    var regExpIsJsFiddle = new RegExp(r'/.*jsfiddle.*/');
    var regExpIsCodePen = new RegExp(r'/.*codepen.*/');
    if (demoLink == null){
      selectedWC['demoType '] = 'none';
    } else if (regExpIsCodePen.hasMatch(demoLink)){
      selectedWC['demoType'] = 'codepen';
    } else if (regExpIsJsFiddle.hasMatch(demoLink)){
      selectedWC['demoType'] = 'jsfiddle';
    } else {
      selectedWC['demoType '] = 'none';
    }
    print("extracted demoType : ${selectedWC['demoType']}");
  }

  
  _setUpJsFiddleData(demoLink){
    selectedWC['demoLinkUrl'] = demoLink + 'embedded/result,js,html,css/';
    print('demoLinkUrl = ' + selectedWC['demoLinkUrl']);
  }

  _setUpCodePenData(demoLink){
    print("set up code pen for demoLink = $demoLink");
    var regExpCodePen = new RegExp(r'/codepen\.io/(.*)/pen/(.*)');
    var matches = regExpCodePen.allMatches(demoLink);
    selectedWC['codePen'] = {
       'user': matches.first.group(1),
       'slugHash': matches.first.group(2)
    };
  }
  
}

