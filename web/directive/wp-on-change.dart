part of webpuzzle;

@NgDirective (
  selector: '[wp-on-change]',
  publishAs: "wpCtrl",
  map: const { 'on-complete': '&onComplete'})
  
class WpOnChange {
  
  Element _element;
  
  @NgTwoWay("wp-on-change")
  Function onChangeCallback;
  
  Function onComplete;
  
  var _ws;
  var _userService;
  var _scope;
  
  WpOnChange(Element this._element, Scope this._scope, WsUrl this._ws, UserService this._userService) {    
    this._element.onChange.listen((e){
      e.preventDefault;
      uploadFile();
    });
  }
  
  uploadFile(){
    var formData = new FormData();
    var inputFile = this._element as InputElement;
    final xhr = new HttpRequest();
    
    var userInfo = this._userService.getUserInfo();
    var jsonUserInfo = JSON.decode(userInfo);
    
    xhr.open('post', '${_ws.webServiceUrl}/uploads.json?auth_token='+this._userService.getToken(), async:true);
    xhr.onReadyStateChange.listen((e){
      if (xhr.readyState == 4 && xhr.status == 201) {
        print('callback ok');
        print(_scope['wc']);
        var response = JSON.decode(xhr.responseText);
        _scope['wc']['imageId']=response['id'];
        _scope['wc']['imageLink'] = response['images']['medium'];
        
      }
      else{
        print(xhr.readyState);
        print(xhr.status);
        print(xhr.responseText);
      }
    });    
    
    inputFile.files.forEach((File file){
      formData.appendBlob('upload[file]',file.slice(),file.name);
    });
    xhr.send(formData); 
  }
  
}