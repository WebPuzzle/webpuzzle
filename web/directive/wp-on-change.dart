part of webpuzzle;

@NgDirective (
  selector: '[wp-on-change]',
  publishAs: "wpCtrl"
 )
class WpOnChange {
  
  Element _element;
  
  @NgTwoWay("wp-on-change")
  Function onChangeCallback;
  
  WpOnChange(Element this._element, Scope scope) {
    print('onChangeCallback $onChangeCallback');
//    _element.onChange.listen((e){
//      
//    });
    
    scope.$watch('wpChange.onChangeCallback', () => print(onChangeCallback));
  }
  
}