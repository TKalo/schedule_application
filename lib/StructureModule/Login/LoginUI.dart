import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/Login/ForgotPasswordUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';
import 'package:schedule_application_entities/DataObjects/UserType.dart';


import 'AuthenticationViewModel.dart';


class LoginUI extends StatelessWidget {

  final String creationWidgetTitle;
  final Widget creationWidget;

  LoginUI({@required UserType userType,@required this.creationWidget, @required this.creationWidgetTitle,@required void Function() onAuthenticated}){
    print('LoginUI - instantiated');
    AuthenticationViewModel().setValues(userType: userType, onAuthenticated: onAuthenticated);
    AuthenticationViewModel().tryLocalLogin();
  }


  @override
  Widget build(BuildContext context) {
    //AuthenticationViewModel().tryLocalLogin(context);
    print('login - built');
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32),
        //Background
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2,
            colors: [Colors.white, Colors.blue[900]],
          )
        ),

        child: StreamBuilder<RequestProgress>(
          stream:  MainViewModel().requestProgress.getData,
          builder: (context, snapshot) {
            RequestProgress progress = snapshot.data ?? RequestProgress.NOT_INITIATED;
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      //Icon
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black
                          ),
                        ),
                      ),

                      Divider(height: 8,color: Colors.transparent,),

                      //Title
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 64),
                            child: CustomTitleText(title: "Coop Works"),
                          )
                      ),


                      //Credentials
                      CustomTextField(
                        title: "username",
                        text:  AuthenticationViewModel().loginEmail,
                        onChanged: (string){ AuthenticationViewModel().loginEmail = string;},
                        validator: (string){return progress == RequestProgress.DENIED ? "credentials denied" : null;;},
                        autovalidateMode: AutovalidateMode.always,
                      ),

                      SizedBox(height: 8),

                      CustomTextField(
                        title: "password",
                        text:  AuthenticationViewModel().loginPassword,
                        onChanged: (string){ AuthenticationViewModel().loginPassword = string;},
                        validator: (string){return progress == RequestProgress.DENIED ? "credentials denied" : null;},
                        autovalidateMode: AutovalidateMode.always,
                      ),

                      SizedBox(height: 32),

                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 320,
                          child: CustomTextButton(
                            title: "login",
                            textSize: 22,
                            onClick: (){
                              AuthenticationViewModel().tryNewLogin();
                            },
                          )
                        ),
                      ),

                      SizedBox(height: 12),

                      Center(
                        child: SizedBox(
                            height: 32,
                            width: 320,
                            child: CustomTextButton(title: "forgot password", textSize: 14, onClick: (){MainViewModel().navigate(location: ForgotPasswordUI());}),
                        ),
                      ),

                      SizedBox(height: 6),
                      Center(
                        child: SizedBox(
                            height: 32,
                            width: 320,
                            child: CustomTextButton(title: creationWidgetTitle, textSize: 14, onClick: (){MainViewModel().navigate(location: creationWidget);})
                        ),
                      ),

                      SizedBox(height: 6),

                      SizedBox(height: 24),
                    ],
                  ),
                  progress == RequestProgress.IN_PROGRESS ? CircularProgressIndicator() : Container()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}


