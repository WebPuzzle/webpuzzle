part of webpuzzle;

@Component(
    selector: 'webcomponent',
    templateUrl: 'components/webcomponent.html',
    publishAs: 'wcCtrl',
    applyAuthorStyles: true
)
class WebcomponentComponent {
  @NgTwoWay("wcmodel")
  var wc;
  
  var wcService;
  var worldService;
  
  @NgTwoWay("clickable")
  var wcClickable = true;
  
  var hovering = false;

  WebcomponentComponent(WebComponentService wcService, WorldService this.worldService){
    this.wcService = wcService;
  }
  
  void selectWC(wc) {
    wcService.selectCurrentWebComponent(wc);
  }
}