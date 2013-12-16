part of webpuzzle;

@NgInjectableService()
class UserService {
  
  Http _http;
  WsUrl _wsUrl;
  var user;
  
  UserService(Http this._http, WsUrl this._wsUrl) {
    updateUserInfo();
  }
  
  String getUserInfo() {
    return window.localStorage['github-user-info'];
  }
  
  void updateUserInfo() {
    if (isConnected())
      user = JSON.decode(getUserInfo());
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
    return _http(method: 'GET', url:'${_wsUrl.webServiceUrl}/auth/github/check', params: {'access_token': token});
  }
  
  void signIn(info) {
    setUserInfo(info);
  }
  
  void signOut() {
    window.localStorage.clear();
  }
  
  bool isConnected() {
    if(getUserInfo() == null) return false;
    else return true;
  }
  
}