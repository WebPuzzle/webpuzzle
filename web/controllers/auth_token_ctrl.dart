part of webpuzzle;

@NgController(
    selector: "[auth-token-ctrl]",
    publishAs: "authTokenCtrl"
)
class AuthTokenCtrl {
  UserService userService;
  RouteProvider routeProvider;
  Router router;

  AuthTokenCtrl(UserService this.userService,
                RouteProvider this.routeProvider,
                Router this.router) {
    print("authentification");
    userService.checkToken(routeProvider.parameters['finalToken'])
      .then(checkTokenSuccess);
  }

  checkTokenSuccess(HttpResponse response){
    userService.setToken(routeProvider.parameters['finalToken']);
    print("set token");
    userService.setUserInfo(JSON.encode(response.data));
    print("set user info ${JSON.encode(response.data)}");
    userService.updateUserInfo();
    router.gotoUrl('/app/list');
  }
  
}