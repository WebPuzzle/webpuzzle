part of webpuzzle;

class WebPuzzleRouteInitializer implements RouteInitializer {
  init(Router router, ViewFactory view) {
    router.root
      ..addRoute(
          name: 'app',
          path: '!/app/:world',
          enter: view('views/app.html'),
          mount: (Route route) => route
                  ..addRoute(
                      name: 'list',
                      path: "/list",
                      enter: view('views/list.html'),
                      defaultRoute: true,
                      mount: (Route route) => route
                      ..addRoute(
                          name: 'detail', 
                          path: '/detail/:id', 
                          enter: view('views/detail.html')
                      ))
                        ..addRoute(
                            name: 'create', 
                            path: '/create', 
                            enter: view('views/create/create.html'),
                            mount: (Route route) => route
                            ..addRoute(
                                name: 'github',
                                path: '/github',
                                enter: view('views/create/github.html')
                            )
                              ..addRoute(
                                  name: 'additionalInfo', 
                                  path: '/additionalInfo', 
                                  enter: view('views/create/additionalInfo.html')
                              )      
                         )
            )
            ..addRoute(
              name: 'authToken',
              path: '/auth/:provider/end/:finalToken',
              enter: view('views/authToken.html')
            )
       
       ..addRoute(
          name: 'worlds',
          path: '/worlds',
          defaultRoute: true,
          enter: view('views/worlds.html')
      );
  }
}