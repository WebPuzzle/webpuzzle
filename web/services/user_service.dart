part of webpuzzle;

@Injectable()
class UserService {
  
  Http _http;
  WsUrl _wsUrl;
  var user;
  
  UserService(Http this._http, WsUrl this._wsUrl) {
    updateUserInfo();
  }

  void updateUserInfo() {
    if (isConnected())
      user = JSON.decode(getUserInfo());
  }

  bool isConnected() {
    if(getUserInfo() == null) return false;
    else return true;
  }

  String getUserInfo() {
    return window.localStorage['github-user-info'];
  }

  void setUserInfo(info) {
    window.localStorage['github-user-info'] = info;
  }

  String getToken() {
    return window.localStorage['github-token'];
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


}