
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';

import 'WorkerRepository.dart';
import 'WorkerViewModel.dart';

class NewUserUI extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);},),
        centerTitle: true,
        title: CustomTitleText(title: "Create New User", fontSize: 24,),
      ),
      body: StreamBuilder<RequestProgress>(
          stream: MainViewModel().requestProgress.getData,
          builder: (context, snapshot) {
            RequestProgress progress = snapshot.data ?? RequestProgress.NOT_INITIATED;
            return Container(
              width: double.infinity,
              color: Colors.blue[200],
              padding: EdgeInsets.all(32),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                CustomTextField(
                                  title: 'key',
                                  text: WorkerRepository().userCreationRequestValues.key ?? '',
                                  onChanged: (string){WorkerRepository().userCreationRequestValues.key = string;},
                                  validator: (text){
                                    if(text == null || text.length != 10) return 'you need a 10 character key given by the store administrator';
                                    else return null;
                                    },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                ),

                                SizedBox(height: 16,),

                                CustomTextField(
                                  title: 'full name',
                                  text: WorkerRepository().userCreationRequestValues.name ?? '',
                                  onChanged: (string){WorkerRepository().userCreationRequestValues.name = string;},
                                  validator: (string){
                                    if(string.isEmpty) return 'cannot be empty';
                                    else return null;
                                  },
                                ),

                                SizedBox(height: 16,),

                                CustomTextField(
                                  title: 'email',
                                  text: WorkerRepository().userCreationRequestValues.email ?? '',
                                  onChanged: (string){WorkerRepository().userCreationRequestValues.email = string;},
                                  validator: (string){
                                    if(!validator.email(string)) return 'must be in the form \'example@example.example\'';
                                    else return null;
                                  },
                                ),

                                SizedBox(height: 16,),

                                CustomTextField(
                                  title: 'password',
                                  text: WorkerRepository().userCreationRequestValues.password ?? '',
                                  onChanged: (string){WorkerRepository().userCreationRequestValues.password = string;},
                                  validator: (string){
                                    if(!validator.mediumPassword(string)) return 'must be at least 8 characters long, must contain letter and number';
                                    else return null;
                                  },
                                ),

                                SizedBox(height: 16,),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16,),

                        SizedBox(
                            height: 50,
                            width: double.maxFinite,
                            child: CustomTextButton(title: "Create", textSize: 22, onClick: (){
                              if(_formKey.currentState.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (tempcontext) {
                                      return AlertDialog(
                                        title: Text('create user'),
                                        actions: [
                                          TextButton(
                                            child: Text('create', style: TextStyle(fontSize: 16),),
                                            onPressed: () {
                                              WorkerViewModel().addUser(context);
                                              MainViewModel().navigate();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                );
                              }
                              },
                            )
                        ),

                        SizedBox(height: 16,),

                        //SizedBox(
                        //    height: 50,
                        //    width: MediaQuery.of(context).size.width-128,
                        //    child: CustomFlatButton(title: "sign in with google", color: Color(0xff4c8bf5), textColor: Colors.white,)
                        //),

                        SizedBox(height: 32,),
                      ],
                    ),
                    progress == RequestProgress.IN_PROGRESS ? CircularProgressIndicator() : Container()
                  ],
                ),
            );
          }
      ),
    );
  }
}
