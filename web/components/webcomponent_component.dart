part of webpuzzle;

@NgComponent(
    selector: 'webcomponent',
    templateUrl: 'components/webcomponent.html',
    publishAs: 'wcCtrl',
    applyAuthorStyles: true
)
class WebcomponentComponent {
  @NgTwoWay("wcmodel")
  var wc;
  var selectedWC;
  
  @NgTwoWay("clickable")
  var wcClickable = true;
  
  var hovering = false;

  WebcomponentComponent(SelectedWCService selectedWC){
    this.selectedWC = selectedWC;
  }
  
  void selectWC(wc) {
    print("this will select a $wc");
    selectedWC.selectedWC = wc;
  }
}