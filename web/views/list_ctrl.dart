part of webpuzzle;

@NgController(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl {
  Router router;
  
  Http _http;
  
  var webcomponents = [];
  
  var filters = ['filtre 1', 'filtre 2'];
  
  var nameFilter = '';
  
  var sortingTypes = [
  {
    'name': 'Ascending alphabetical order',
    'iconCss': 'fa fa-sort-alpha-asc',
    'filter': 'name'
  },
  {
    'name': 'Descending alphabetical order',
    'iconCss': 'fa fa-sort-alpha-desc',
    'filter': '-name'
  },
  {
    'name': 'Descending popularity order',
    'iconCss': 'fa fa-sort-amount-desc',
    'filter': '-popularity'
  },
  {
    'name': 'Ascending popularity order',
    'iconCss': 'fa fa-sort-amount-asc',
    'filter': 'popularity'
  }
  ];

  var filterTypes = [
   {
     'name': 'By name',
     'filter': 'name'
   },
   {
     'name': 'By author',
     'filter': 'submitter'
   }
   ];
  
  var viewMode;

  ListCtrl(Router this.router, Http this._http){
    _http(method: 'GET', url: 'webcomponents.json').then((HttpResponse data) {
      webcomponents = data.data;
    });
    viewMode = router.activePath.last.name;
    print("viewMode is now $viewMode");
    router.onRouteStart.listen((RouteStartEvent rse) {
      rse.completed.then((bool){
        viewMode = router.activePath.last.name;
        print("viewMode is now $viewMode");
      });
    });
      
    
  }
}