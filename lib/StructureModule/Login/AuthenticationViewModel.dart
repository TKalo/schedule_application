
import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/RequestProgress.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketConnection.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketSingleValue.dart';
import 'package:schedule_application_entities/DataObjects/UserType.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationViewModel {
  static final AuthenticationViewModel _singleton = AuthenticationViewModel._internal();
  factory AuthenticationViewModel(){return _singleton;}
  AuthenticationViewModel._internal();

  setValues({@required UserType userType,@required void Function() onAuthenticated}){
    this.userType = userType;
    this.onAuthenticated = onAuthenticated;
  }

  DateTime loginCalled;
  String loginEmail;
  String loginPassword;
  UserType userType;
  void Function() onAuthenticated;

  tryLocalLogin() async {

    //abort if call was made less than 2 seconds ago
    print('tryLocalLogin  - initiated');
    if((loginCalled != null && loginCalled.isAfter(DateTime.now().subtract(Duration(seconds: 2))))) return;
    loginCalled = DateTime.now();
    print('tryLocalLogin  - activated');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    WebSocketConnection().connect(
        email: prefs.getString('current_user_email'),
        password: prefs.getString('current_user_password'),
        userType: userType,
        onConnect: () async {
          print('tryLocalLogin  - connected');
          MainViewModel().currentUser.setData(await WebSocketSingleValue().getCurrentUser());
          onAuthenticated();
        },
        onError: (String error){}
    );
  }

  void tryNewLogin() async {
    if((loginCalled == null || loginCalled.isBefore(DateTime.now().subtract(Duration(seconds: 2)))) && ![loginEmail,loginPassword].contains(null)) {
      loginCalled = DateTime.now();
      MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);

      WebSocketConnection().connect(
          email: loginEmail,
          password: loginPassword,
          userType: userType,
          onConnect: () async {
            //TempClientSingleton().client.deactivate();
            MainViewModel().requestProgress.setData(RequestProgress.ACCEPTED);
            MainViewModel().currentUser.setData(await WebSocketSingleValue().getCurrentUser());

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('current_user_email',loginEmail);
            prefs.setString('current_user_password', loginPassword);
            onAuthenticated();
          },
          onError: (String error) {
            //Toast.show(error, context, duration: 3);
            MainViewModel().requestProgress.setData(RequestProgress.DENIED);
          }
      );
    }
  }
}