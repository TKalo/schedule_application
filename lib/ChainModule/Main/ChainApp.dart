


import 'package:flutter/material.dart';
import 'package:schedule_application/StoreModule/Main/StoreMainUI.dart';
import 'package:schedule_application/StoreModule/Main/StoreRepository.dart';
import 'package:schedule_application/StructureModule/Login/LoginUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketSingleValue.dart';
import 'package:schedule_application_entities/DataObjects/UserType.dart';

import 'ChainCreationUI.dart';

void main() => runApp(Application());

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coop Works",
      theme: ThemeData(),
      navigatorKey: MainViewModel().navigatorKey,
      routes: {'/' : (context) => LoginUI(
          userType: UserType.store_administrator,
          creationWidget: ChainCreationUI(),
          creationWidgetTitle: "new chain",
          onAuthenticated: () {
            WebSocketSingleValue().getCurrentUserStore().then((value) => StoreRepository().currentUserStore.setData(value));
            MainViewModel().navigate(location: StoreMainUI());
          })
      },
    );
  }
}
