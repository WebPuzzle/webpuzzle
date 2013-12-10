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
  
  @NgTwoWay("clickable")
  var wcClickable = true;
  
  var hovering = false;

  WebcomponentComponent(){
  }
  
  void selectWC(wc) {
    print("this will select a $wc");
  }
}