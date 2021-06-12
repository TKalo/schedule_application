import 'package:flutter/cupertino.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/WorkerUIModule/Main/WorkerRepository.dart';
import 'package:schedule_application_conn/ConnectionModule/RestConnection.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';
import 'package:toast/toast.dart';

class WorkerViewModel {
  static final WorkerViewModel _singleton = WorkerViewModel._internal();
  factory WorkerViewModel(){return _singleton;}
  WorkerViewModel._internal();

  void addUser(BuildContext context) async {
    MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);
    bool result = await RestConnection().addUser(WorkerRepository().userCreationRequestValues, (String error){Toast.show(error, context, duration: 3);});
    if(result){
      MainViewModel().requestProgress.setData(RequestProgress.ACCEPTED);
      MainViewModel().navigate();
    }else{
      MainViewModel().requestProgress.setData(RequestProgress.DENIED);
    }
  }
}