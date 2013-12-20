library webpuzzle_app;
import 'package:unittest/unittest.dart';
import 'package:dartmocks/dartmocks.dart';
import 'dart:async';
import 'dart:html' as html;

import '../../web/webpuzzle.dart';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:angular/mock/module.dart';

class TestWsUrl extends TestDouble implements WsUrl{ var webServiceUrl = "url";}
class TestUserService extends TestDouble implements UserService{ var user = "user";}
class TestWebComponentService extends TestDouble implements WebComponentService{}

main(){
  group("[AppCtrl]", (){
    var wsUrl, userService, webComponentService;

    setUp((){
      wsUrl = new TestWsUrl();
      userService = new TestUserService();
      webComponentService = new TestWebComponentService();
    });

    test("storing the call", (){
      final appCtrl = new AppCtrl(wsUrl, userService, webComponentService);
      expect(appCtrl.user, equals("user"));
      expect(appCtrl.authentUrl, equals("url/auth/github/send"));
    });
  });
}