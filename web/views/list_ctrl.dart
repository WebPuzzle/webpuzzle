part of talk_to_me;

@NgController(
    selector: '[list-ctrl]',
    publishAs: 'listCtrl'
)
class ListCtrl {
  Router router;
  
  var webcomponents = [
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partridge'},
  {'name'  : 'fgdfg'},
  {'name'  : 'partfdgdfgdfgdfgdfgdfgridge'}
  ];
  
  var filters = ['filtre 1', 'filtre 2'];
  
  var sortingTypes = [
    {'name'  : 'asc'},
    {'name'  : 'desc'},
    {'name'  : 'pop'},
    {'name'  : 'pop inv'}
  ];

  ListCtrl(this.router){
  }
}