part of webpuzzle;

@NgController(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  int currentId;
  WebComponentService wcService;
  var selectedWC;
  
  DetailCtrl (RouteProvider routeProvider , WebComponentService this.wcService, Http http){
    selectedWC = wcService.selectedWC;
    currentId = int.parse(routeProvider.parameters["id"]);
    if (selectedWC == null){
      wcService.dataInitialized().then((dynamic) {
      wcService.selectCurrentWebComponentFromId(currentId);
      selectedWC = wcService.selectedWC;
      setUpDemo(selectedWC);
      print("No selectedWC in memory, using url parameter 'id'");
    });
    }else {
      setUpDemo(selectedWC);
    }
  }  

  setUpDemo(selectedWC){
    //selectedWC['demoLink'] = 'http://codepen.io/bradleybossard/pen/KoyAa';
    //selectedWC['demoLink'] = 'http://jsfiddle.net/jgoemat/kta95/';
    _extractDemoType(selectedWC['demoLink']);
    if (selectedWC['demoType'] == 'codepen'){
      _setUpCodePenData(selectedWC['demoLink']);
    }
    if (selectedWC['demoType'] == 'jsfiddle'){
      _setUpJsFiddleData(selectedWC['demoLink']);
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

