part of webpuzzle;

@Controller(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl {
  Router router;
  Http _http;
  Scope scope;
  var webcomponents = [{}];
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
    scope.on("worldChanged").listen(loadData);
    loadData();
    viewMode = router.activePath.last.name;
    router.onRouteStart.listen((RouteStartEvent rse) {
      rse.completed.then((bool){
        viewMode = router.activePath.last.name;
      });
    });
    
    //Binding a custom filterObject to the view to filter by name and submitter
    scope.watch('listCtrl.nameFilter', (oldData, data) => filterObject[selectedFilter] = nameFilter);
    scope.watch('listCtrl.selectedFilter',(oldData, data) {
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
    
    scope.context['getValueFromTimestamp'] = getValueFromTimestamp;
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
  
  getValueFromTimestamp(wc){
    if (wc['updated_at'] == null){
      return 0;
    }
    DateTime date = DateTime.parse(wc['updated_at']);
    return -date.millisecondsSinceEpoch;
  }
}