part of webpuzzle;

@NgInjectableService()
class WsUrl {
  var webServiceUrl;
  
  WsUrl() {
    webServiceUrl = 'https://webpuzzlews.herokuapp.com';
    //Local configuration, removed at build time
    //@exclude
    webServiceUrl = 'http://localhost:3000';
    //@endexclude
    
  }

}