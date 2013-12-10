part of talk_to_me;

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
               enter: view('views/list.html')
      ));
  }
}