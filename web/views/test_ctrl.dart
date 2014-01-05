part of webpuzzle;

@NgController(
    selector: '[test-ctrl]',
    publishAs: 'testCtrl'
)
class TestCtrl {
  Router router;
  Http _http;
  WsUrl _ws;
  
  TestCtrl(Http this._http, WsUrl this._ws){
    
//    document.
//    if (document.readyState == "complete") {
//      onReady();
//    }

//    uploadInput.onChange.listen((e) {    
//      print("test");
//      var formData = new FormData();
//      
//      final xhr = new HttpRequest();
//      xhr.open('post', '${_ws.webServiceUrl}/uploads.json', async:true);
//      xhr.onReadyStateChange.listen((e){
//        if (xhr.readyState == 4 && xhr.status == 200) {
//          print('callback ok');
//        }            
//      });
//      uploadInput.files.forEach((File file){
//        formData.appendBlob('upload[file]',file.slice(),file.name);
//      });
//      xhr.send(formData);
//    });
    
  }
  
  void onChange(){
      var formData = new FormData();
      
      final xhr = new HttpRequest();
      xhr.open('post', '${_ws.webServiceUrl}/uploads.json', async:true);
      xhr.onReadyStateChange.listen((e){
        if (xhr.readyState == 4 && xhr.status == 200) {
          print('callback ok');
        }            
      });
      uploadInput.files.forEach((File file){
        formData.appendBlob('upload[file]',file.slice(),file.name);
      });
      xhr.send(formData); 
  }
}