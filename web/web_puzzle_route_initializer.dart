part of webpuzzle;

class WebPuzzleRouteInitializer implements RouteInitializer {
  init(Router router, ViewFactory view) {
    router.root
      ..addRoute(
          name: 'app',
          path: '/app',
          enter: view('views/app.html'),
          defaultRoute: true,
          mount: (Route route) => route
            ..addRoute(
               name: 'list',
               path: "/list",
               defaultRoute: true,
               enter: view('views/list.html'),
               mount: (Route route) => route
                  ..addRoute(
                      name: 'detail', 
                      path: '/detail/:id', 
                      enter: view('views/detail.html')
               
      )));
  }
}