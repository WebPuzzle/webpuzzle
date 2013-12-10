part of talk_to_me;

@NgController(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl {
  Router router;
  
  Http _http;
  
  var webcomponents;
  
  var filters = ['filtre 1', 'filtre 2'];
  
  var sortingTypes = [
    {'name'  : 'asc'},
    {'name'  : 'desc'},
    {'name'  : 'pop'},
    {'name'  : 'pop inv'}
  ];

  ListCtrl(Router this.router, Http this._http){
    _http(method: 'GET', url: 'webcomponents.json').then((HttpResponse data) {
      webcomponents = data.data;
      print(data);
    });
  }
}