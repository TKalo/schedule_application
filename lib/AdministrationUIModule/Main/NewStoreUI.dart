
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:schedule_application/AdministrationUIModule/Main/AdminRepository.dart';
import 'package:schedule_application/AdministrationUIModule/Main/AdminViewModel.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';

class NewStoreUI extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {MainViewModel().navigate();},),
        centerTitle: true,
        title: CustomTitleText(title: 'Create New Store', fontSize: 24,),
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
                              title: 'full name',
                              hint: 'information of the super admin responsible for the store',
                              text: AdminRepository().storeCreationValues.name ?? '',
                              onChanged: (string){AdminRepository().storeCreationValues.name = string;},
                              validator: (string){
                                if(string.isEmpty) return 'cannot be empty';
                                else return null;
                              },
                            ),

                            Divider(height: 16, color: Colors.transparent,),

                            Divider(height: 16, color: Colors.transparent,),

                            CustomTextField(
                              title: 'email',
                              hint: 'information of the super admin responsible for the store',
                              text: AdminRepository().storeCreationValues.email ?? '',
                              onChanged: (string){AdminRepository().storeCreationValues.email = string;},
                              validator: (string){
                                if(!validator.email(string)) return 'must be in the form \'example@example.example\'';
                                else return null;
                              },
                            ),

                            Divider(height: 16, color: Colors.transparent,),

                            CustomTextField(
                              title: 'password',
                              hint: 'information of the super admin responsible for the store',
                              text: AdminRepository().storeCreationValues.password ?? '',
                              onChanged: (string){AdminRepository().storeCreationValues.password = string;},
                              validator: (string){
                                if(!validator.mediumPassword(string)) return 'must be at least 8 characters long, must contain letter and number';
                                else return null;
                              },

                            ),

                            Divider(height: 16, color: Colors.transparent,),

                            CustomTextField(
                              title: 'address',
                              hint: 'information of store',
                              text: AdminRepository().storeCreationValues.address ?? '',
                              onChanged: (string){AdminRepository().storeCreationValues.address = string;},
                              validator: (string){
                                if(string.isEmpty) return 'cannot be empty';
                                else return null;
                              },
                            ),

                            Divider(height: 16, color: Colors.transparent,),

                            CustomTextField(
                              title: 'city of store',
                              hint: 'information of store',
                              text: AdminRepository().storeCreationValues.city ?? '',
                              onChanged: (string){AdminRepository().storeCreationValues.city = string;},
                              validator: (string){
                                if(string.isEmpty) return 'cannot be empty';
                                else return null;
                              },
                            ),

                            Divider(height: 16, color: Colors.transparent,),
                          ],
                        ),
                      ),
                    ),

                    Divider(height: 16, color: Colors.transparent,),

                    SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: CustomTextButton(title: 'Create', textSize: 22, onClick: (){
                          if(_formKey.currentState.validate()) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('create new store'),
                                    actions: [
                                      TextButton(
                                        child: Text('create', style: TextStyle(fontSize: 16),),
                                        onPressed: () => AdminViewModel().addDepartment(),
                                      )
                                    ],
                                  );
                                }
                            );
                          }
                        },)
                    ),

                    Divider(height: 32, color: Colors.transparent,),
                  ],
                ),
                progress == RequestProgress.IN_PROGRESS ? CircularProgressIndicator() : Container()
              ]
            ),
          );
        }
      ),
    );
  }
}