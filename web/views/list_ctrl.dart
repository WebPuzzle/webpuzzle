part of webpuzzle;

@NgController(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl {
  Router router;
  Http _http;
  Scope scope;
  var webcomponents = [];
  var nameFilter = '';
  var sortingTypes;
  var filterTypes;
  var selectedSortingFilter = 'name';
  var selectedFilter = 'name';
  var viewMode;
  var filterObject = {'name': '', 'submitter': ''};
  
  var bool = true;

  ListCtrl(Router this.router, WebComponentService wcService, Scope this.scope){
    wcService.dataInitialized().then((data) => webcomponents = data);
    viewMode = router.activePath.last.name;
    router.onRouteStart.listen((RouteStartEvent rse) {
      rse.completed.then((bool){
        viewMode = router.activePath.last.name;
      });
    });
    
    //Binding a custom filterObject to the view to filter by name and submitter
    scope.$watch('listCtrl.nameFilter', () => filterObject[selectedFilter] = nameFilter);
    scope.$watch('listCtrl.selectedFilter',() {
      filterObject = {'name': '', 'submitter': ''};
      filterObject[selectedFilter] = nameFilter;
    });
    
    sortingTypes = [
   {
     'name': 'Ascending alphabetical order',
     'iconCss': 'fa fa-sort-alpha-asc',
     'filter': 'name',
     'selected' : true
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
     'filter': 'name',
     'selected' : true
   },
   {
     'name': 'By author',
     'filter': 'submitter',
     'selected': false
   }
   ];
  }
  
  selectSortingType(sortingType){
    sortingTypes.forEach((type) => type['selected'] = false);
    sortingType['selected'] = true;
    selectedSortingFilter = sortingType['filter'];

  }
  
  selectFilterType(filter){
    filterTypes.forEach((type) => type['selected'] = false);
    filter['selected'] = true;
    selectedFilter = filter['filter'];
  }
}