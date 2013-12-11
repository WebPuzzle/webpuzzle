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
  var sortingTypes;
  var filterTypes;
  var selectedSortingFilter = 'name';
  var viewMode;
  
  var bool = true;

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
    
    sortingTypes = [
   {
     'name': 'Ascending alphabetical order',
     'iconCss': 'fa fa-sort-alpha-asc',
     'filter': 'name',
     'selected' : false
   },
   {
     'name': 'Descending alphabetical order',
     'iconCss': 'fa fa-sort-alpha-desc',
     'filter': '-name',
     'selected' : false
   },
   {
     'name': 'Descending popularity order',
     'iconCss': 'fa fa-sort-amount-desc',
     'filter': '-popularity',
     'selected' : false
   },
   {
     'name': 'Ascending popularity order',
     'iconCss': 'fa fa-sort-amount-asc',
     'filter': 'popularity',
     'selected' : false
   }
   ];
    
    filterTypes = [
   {
     'name': 'By name',
     'filter': 'name'
   },
   {
     'name': 'By author',
     'filter': 'submitter'
   }
   ];
  }
  
  selectSortingType(sortingType){
    sortingType['selected'] = true;
    sortingTypes.forEach((type) => type['selected'] = false);
    selectedSortingFilter = sortingType['filter'];
  }
}