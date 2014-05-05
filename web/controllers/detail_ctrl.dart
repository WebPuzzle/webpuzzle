part of webpuzzle;

@Controller(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  int currentId;
  WebComponentService webComponentService;
  WorldService worldService;
  var selectedWC;
  
  //used in unit test
  Future testControllerInitializedAsync;
  
  //initialize selected web component and setsUp demo data
  DetailCtrl (RouteProvider routeProvider , WebComponentService this.webComponentService, WorldService this.worldService){
    selectedWC = webComponentService.selectedWC;
    currentId = int.parse(routeProvider.parameters["id"]);
    print("selectedWC : $selectedWC");
    if (selectedWC == null){
      testControllerInitializedAsync = webComponentService.dataInitialized().then((dynamic) {
        webComponentService.selectCurrentWebComponentById(currentId);
        selectedWC = webComponentService.selectedWC;
        setUpDemo(selectedWC);
        print("No selectedWC in memory, using url parameter 'id'");
      });
    }else {
      setUpDemo(selectedWC);
    }
  }

  //sets up demo data based on web component's demoLink
  setUpDemo(selectedWC){
    print("demoLink : ${selectedWC['demoLink']}");
    if (selectedWC != null){
      _extractDemoType(selectedWC['demoLink']);
      if (selectedWC['demoType'] == 'codepen'){
        _setUpCodePenData(selectedWC['demoLink']);
      }
      if (selectedWC['demoType'] == 'jsfiddle'){
        _setUpJsFiddleData(selectedWC['demoLink']);
      }
      if (selectedWC['demoType'] == 'plunker'){
        _setUpPlunkerData(selectedWC['demoLink']);
      }
    }else {
      print("cannot setUpDemo, selectedWC is null");
    }
  }

  _extractDemoType(demoLink){
    var regExpIsJsFiddle = new RegExp(r'/.*jsfiddle.*/');
    var regExpIsCodePen = new RegExp(r'/.*codepen.*/');
    var regExpIsPlunker = new RegExp(r'/.*plnkr.*/');
    if (demoLink == null){
      selectedWC['demoType '] = 'none';
    } else if (regExpIsCodePen.hasMatch(demoLink)){
      selectedWC['demoType'] = 'codepen';
    } else if (regExpIsJsFiddle.hasMatch(demoLink)){
      selectedWC['demoType'] = 'jsfiddle';
    } else if (regExpIsPlunker.hasMatch(demoLink)){
      selectedWC['demoType'] = 'plunker';
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
  
  _setUpPlunkerData(demoLink){
    print("demoLink $demoLink");
    //supports those formats :
    //http://plnkr.co/ofvGnY
    //http://plnkr.co/edit/ofvGnY
    //http://plnkr.co/edit/ZJY4rQ?p=info
    //http://embed.plnkr.co/479Ru8/preview
    var regExpPlunker = new RegExp(r'plnkr.co/(edit/)?(\w*)');
    var matches = regExpPlunker.allMatches(demoLink);
    selectedWC['plunkerDemoCode'] = matches.first.group(2);
    print("match : ${matches.first.group(2)}");
  }
  
}

