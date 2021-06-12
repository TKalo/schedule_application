
import 'package:schedule_application/AdministrationUIModule/Main/AdminRepository.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_conn/ConnectionModule/RestConnection.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';

class AdminViewModel {
  static final AdminViewModel _singleton = AdminViewModel._internal();
  factory AdminViewModel(){return _singleton;}
  AdminViewModel._internal();

  void addDepartment() async{
    MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);
    bool result = await RestConnection().addDepartment(AdminRepository().storeCreationValues);
    if(result){
      MainViewModel().requestProgress.setData(RequestProgress.ACCEPTED);
      MainViewModel().navigate();
    }else MainViewModel().requestProgress.setData(RequestProgress.DENIED);
  }
}