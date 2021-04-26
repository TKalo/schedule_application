import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/Login/LoginUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_entities/DataObjects/UserType.dart';
import 'NewUserUI.dart';
import 'WorkerMainUI.dart';

void main() {
  runApp(Application());
}

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
      home: LoginUI(
          userType: UserType.worker,
          creationWidget: NewUserUI(),
          creationWidgetTitle: "new user",
          onAuthenticated: (){MainViewModel().navigate(location: WorkerMainUI());}
      ),
    );
  }
}
