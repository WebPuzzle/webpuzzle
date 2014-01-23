part of webpuzzle;

@NgController(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl implements NgDetachAware {
  Router router;
  Http _http;
  Scope scope;
  var webcomponents = [];
  var nameFilter = '';
  var sortingTypes;
  var filterTypes;
  var selectedSortingFilter;
  var selectedFilter = 'name';
  var viewMode;
  var filterObject = {'name': '', 'submitter': ''};
  
  WebComponentService _wcService;
  WorldService _worldService;
  
  var bool = true;

  ListCtrl(Router this.router, Scope this.scope, WebComponentService this._wcService, WorldService this._worldService){
    _worldService.onChangeWorld(loadData);
    loadData();
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
      'name': 'Newest',
      'iconCss': 'fa fa-clock-o',
      'filter': getValueFromTimestamp,
      'selected' : true
    },
   {
     'name': 'Ascending alphabetical order',
     'iconCss': 'fa fa-sort-alpha-asc',
     'filter': 'name',
     'selected' : false
   }
   ];
    
    selectedSortingFilter = getValueFromTimestamp;
    
    filterTypes = [
   {
     'name': 'By name',
     'filter': 'name',
     'selected' : true
   },
   {
     'name': 'By author',
     'filter': 'author',
     'selected': false
   }
   ];
    
    scope["getValueFromTimestamp"] = getValueFromTimestamp;
  }
  
  detach() {
    _worldService.removeOnChangeWorldCallback(loadData);
  }
  
  loadData() {
    return _wcService.loadWc().then((data) => webcomponents = data);
  }
  
  //Sets the selected flags to true for a given sortingType object
  //Resets all other flags to false
  selectSortingType(sortingType){
    sortingTypes.forEach((type) => type['selected'] = false);
    sortingType['selected'] = true;
    selectedSortingFilter = sortingType['filter'];

  }
  
  //Sets the selected flags to true for a given filterType object
  //Resets all other flags to false
  selectFilterType(filter){
    filterTypes.forEach((type) => type['selected'] = false);
    filter['selected'] = true;
    selectedFilter = filter['filter'];
  }
  
  getValueFromTimestamp(timestamp){
    DateTime date = DateTime.parse(timestamp['updated_at']);
    return -date.millisecondsSinceEpoch;
  }
}