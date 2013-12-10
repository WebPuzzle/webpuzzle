part of webpuzzle;

@NgController(
    selector: "[detail-ctrl]",
    publishAs: "detailCtrl"
)
class DetailCtrl {

  var selectedWCService;
  
  var selectedWC;
  
  DetailCtrl (Scope scope, SelectedWC selectedWC){
    this.selectedWCService = selectedWC;
    this.selectedWC = selectedWCService.selectedWC;
    print("selectedWC in found in detail is ${this.selectedWC}");
  }
}

