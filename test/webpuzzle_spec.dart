library webpuzzle_spec;

import 'package:unittest/unittest.dart';
import 'package:dartmocks/dartmocks.dart';
import 'dart:async';
import 'dart:html' as html;

import '../web/webpuzzle.dart';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:angular/mock/module.dart';

part 'controllers/app_ctrl_spec.dart';
part 'controllers/list_ctrl_spec.dart';

main(){
  testAppCtrl();
  testListCtrl();
}