


import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:schedule_application/AdministrationUIModule/UserRequests/WorkerRequestsViewModel.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';

class WorkerCreationUI extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {MainViewModel().navigate();},),
        centerTitle: true,
        title: CustomTitleText(title: 'worker creation', fontSize: 24,),
      ),
      body: StreamBuilder<Object>(
        stream: MainViewModel().requestProgress.getData,
        builder: (context, snapshot) {
          RequestProgress progress = snapshot.data ?? RequestProgress.NOT_INITIATED;
          return Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: StreamBuilder<Object>(
                          stream: WorkerRequestsViewModel().workerType.getData,
                          builder: (context, snapshot) {
                            return ListView(
                              shrinkWrap: true,
                              children: [
                                CustomDropDownButton(
                                  title: 'weekday',
                                  value: snapshot.data,
                                  color: Colors.blue,
                                  items: WorkerType.values.map<DropdownMenuItem<WorkerType>>((weekDay) => DropdownMenuItem(value: weekDay, child: Text(EnumToString.convertToString(weekDay),))).toList(),
                                  onChanged: (workerType)=>WorkerRequestsViewModel().workerType.setData(workerType)
                                ),
                              ],
                            );
                          }
                        )
                    ),

                    SizedBox(height: 32,),

                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: CustomTextButton(
                        title: 'request worker creation'.toUpperCase(),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onClick: () async {
                          if(_formKey.currentState.validate()){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text('request worker creation'),
                                    content: Text(''),
                                    actions: [
                                      TextButton(
                                        child: Text("create", style: TextStyle(fontSize: 16),),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          WorkerRequestsViewModel().addWorkerCreationRequest();
                                        },
                                      )
                                    ],
                                  );
                                }
                            );
                          }},
                      ),
                    ),
                  ],
                ),
              ),
              progress == RequestProgress.IN_PROGRESS ? CircularProgressIndicator() : Container()
            ]
          );
        }
      ),
    );
  }
}
