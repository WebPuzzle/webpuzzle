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
  
  var wcService;
  
  @NgTwoWay("clickable")
  var wcClickable = true;
  
  var hovering = false;

  WebcomponentComponent(WebComponentService wcService){
    this.wcService = wcService;
  }
  
  void selectWC(wc) {
    wcService.selectCurrentWebComponent(wc);
  }
}