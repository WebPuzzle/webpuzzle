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

  WebcomponentComponent(){
    print("agenda is here !!");
    print(wc);
  }
}