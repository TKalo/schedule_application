
import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/Login/LoginUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketConnection.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketSingleValue.dart';
import 'package:schedule_application_entities/DataObjects/UserType.dart';

import 'StoreMainUI.dart';
import 'StoreRepository.dart';
import 'StoreCreationUI.dart';

void main() => runApp(Application());

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Coop Works",
      theme: ThemeData(),
      navigatorKey: MainViewModel().navigatorKey,
      routes: {'/' : (context) => LoginUI(
          userType: UserType.store_administrator,
          creationWidget: StoreCreationUI(),
          creationWidgetTitle: "new store",
          onAuthenticated: () {
            WebSocketSingleValue().getCurrentUserStore().then((value) => StoreRepository().currentUserStore.setData(value));
            MainViewModel().navigate(location: StoreMainUI());
          })
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.inactive) WebSocketConnection().client?.deactivate();
    super.didChangeAppLifecycleState(state);
  }

  @mustCallSuper
  @protected
  @override
  void dispose() {
    WebSocketConnection().client?.deactivate();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
