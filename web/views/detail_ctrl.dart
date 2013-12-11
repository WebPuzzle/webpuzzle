part of webpuzzle;

@NgController(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  var currentId;
  var selectedWCService;
  var selectedWC;
  
  DetailCtrl (RouteProvider routeProvider , SelectedWCService this.selectedWCService, Http http){
    selectedWC = selectedWCService.selectedWC;
    currentId = routeProvider.parameters["id"];
    if (selectedWC == null){
      http.get('http://webpuzzlews.herokuapp.com/web_components/$currentId.json').then((HttpResponse response) {
      selectedWCService.selectedWC = response.data;
      selectedWC = response.data;
      setUpDemo(selectedWC);
      print("No selectedWC in memory, got data from WS");
    });
    }else {
      setUpDemo(selectedWC);
    }
  }  

  setUpDemo(selectedWC){
    selectedWC['demoLink'] = 'http://codepen.io/bradleybossard/pen/KoyAa';
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
    if (regExpIsCodePen.hasMatch(demoLink)){
      selectedWC['demoType'] = 'codepen';
    } else if (regExpIsJsFiddle.hasMatch(demoLink)){
      selectedWC['demoType'] = 'jsfiddle';
    } else {
      selectedWC['demoType '] = 'none';
    }
    print("extracted demoType : " + selectedWC['demoType']);
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

