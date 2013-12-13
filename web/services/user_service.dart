part of webpuzzle;

@NgInjectableService()
class UserService {
  
  Window window;
  Http _http;
  WsUrl _wsUrl;
  
  UserService(Http this._http, WsUrl this._wsUrl) {
    
  }
  
  String getUserInfo() {
    return window.localStorage['github-user-info'];
  }
  
  void setUserInfo(info) {
    window.localStorage['github-user-info'] = info;
  }
  
  String getToken() {
    return window.localStorage['github-user-info'];
  }
  
  void setToken(String token) {
    window.localStorage['github-token'] = token;
  }
  
  Future<HttpResponse> checkToken(token) {
    return _http(method: 'GET', url:'$_wsUrl.webServiceUrl');
  }
  
  void signIn(info) {
    setUserInfo(info);
  }
  
  void signOut() {
    window.localStorage.clear();
  }
  
  bool isConnected() {
    if(getUserInfo().isEmpty) return false;
    else return true;
  }
  
}