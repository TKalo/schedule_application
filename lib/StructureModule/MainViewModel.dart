

import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';
import 'package:schedule_application_entities/DataObjects/User.dart';


class MainViewModel {
  static final MainViewModel _singleton = MainViewModel._internal();
  factory MainViewModel(){return _singleton;}
  MainViewModel._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final RxValue<RequestProgress> requestProgress = RxValue(startWith: RequestProgress.NOT_INITIATED);
  final RxValue<User> currentUser = RxValue();

  void drawerState(bool open){
    if(open) scaffoldKey.currentState.openEndDrawer();
    else if(scaffoldKey.currentState != null && scaffoldKey.currentState.isEndDrawerOpen) navigatorKey.currentState.pop();
  }

  void navigate({String route, Widget location}){
    drawerState(false);
    assert((route != null && location == null) || (route == null && location != null) || (route == null && location == null));
    if(location != null) navigatorKey.currentState.push(MaterialPageRoute(builder: (c) => location));
    if(route != null) navigatorKey.currentState.pushNamed(route);
    if(route == null && location == null) navigatorKey.currentState.pop();
  }

  logout() {
  }

}