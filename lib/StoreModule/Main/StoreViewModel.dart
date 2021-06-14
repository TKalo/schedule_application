
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_conn/ConnectionModule/RestConnection.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';

import 'StoreRepository.dart';

class StoreViewModel {
  static final StoreViewModel _singleton = StoreViewModel._internal();
  factory StoreViewModel() => _singleton;
  StoreViewModel._internal();

  void addDepartment() async{
    MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);
    bool result = await RestConnection().addDepartment(StoreRepository().storeCreationValues);
    if(result){
      MainViewModel().requestProgress.setData(RequestProgress.ACCEPTED);
      MainViewModel().navigate();
    }else MainViewModel().requestProgress.setData(RequestProgress.DENIED);
  }
}