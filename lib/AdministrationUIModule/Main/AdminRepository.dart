

import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application_conn/ConnectionModule/Post.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketSubscription.dart';
import 'package:schedule_application_entities/DataObjects/ScheduleTemplate.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';
import 'package:schedule_application_entities/DataObjects/Store.dart';
import 'package:schedule_application_entities/DataObjects/StoreCreationValues.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';

class AdminRepository{
  static final AdminRepository _singleton = AdminRepository._internal();
  factory AdminRepository(){return _singleton;}
  AdminRepository._internal(){
    getData();
  }

  final StoreCreationValues storeCreationValues = StoreCreationValues();

  final RxList<ShiftTemplate> shifts = RxList(startWith: []);
  final RxMap<int, WorkerCreationRequest> userCreationRequests = RxMap();
  final RxValue<Store> currentUserStore = RxValue();
  final RxValue<ScheduleTemplate> scheduleTemplate = RxValue();

  void getData()async{
    WebSocketSubscriptions().userCreationRequestSubscribe((await currentUserStore.getData.first).id, (result){
      if([PostCommand.ADD, PostCommand.UPDATE].contains(result.command)){
        result.resultList.forEach((request) => userCreationRequests.addData(request.id, request));
      }else if(PostCommand.DELETE == result.command){
        result.resultList.forEach((request) => userCreationRequests.removeData(request.id));
      }else{
        print('ERROR: AdminRepository\\getData - command not recognized');
      }
    });

    WebSocketSubscriptions().scheduleTemplate((await currentUserStore.getData.first).id, (result){
      if([PostCommand.ADD, PostCommand.UPDATE].contains(result.command)){
        scheduleTemplate.setData(result.resultList.first);
      }else{
        print('ERROR: AdminRepository\\getData - command not recognized');
      }
    });
  }
}