

import 'package:schedule_application/StoreModule/Main/StoreRepository.dart';
import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketRequest.dart';
import 'package:schedule_application_entities/DataObjects/ScheduleTemplate.dart';

class ScheduleDeadlineViewModel {
  static final ScheduleDeadlineViewModel _singleton = ScheduleDeadlineViewModel._internal();
  factory ScheduleDeadlineViewModel(){return _singleton;}
  ScheduleDeadlineViewModel._internal(){
    localDeadlines.setData(ScheduleTemplate());
    StoreRepository().scheduleDeadlines.getData.listen((value) {
      savedDeadlines = ScheduleTemplate(storeId: value.storeId, preferenceDeadline: value.preferenceDeadline, creationDeadline: value.creationDeadline, initiationDeadline: value.initiationDeadline, weeks: value.weeks);
      localDeadlines.setData(value);});
    localDeadlines.getData.listen((template) => setDateTimeLimitations(template));
  }

  ScheduleTemplate savedDeadlines = ScheduleTemplate();
  RxValue<ScheduleTemplate> localDeadlines = RxValue();
  int scheduleWeekDuration;
  DateTime prefMin = DateTime.now().add(Duration(days: 3));
  DateTime prefMax = DateTime.now().add(Duration(days: 365));
  DateTime creationMin = DateTime.now().add(Duration(days: 6));
  DateTime creationMax = DateTime.now().add(Duration(days: 365));
  DateTime initiationMin = DateTime.now().add(Duration(days: 9));
  DateTime initiationMax = DateTime.now().add(Duration(days: 365));
  
  void setDateTimeLimitations(ScheduleTemplate deadlines){
    print(savedDeadlines.toJson());
    prefMin =  savedDeadlines.preferenceDeadline != null && savedDeadlines.preferenceDeadline.isBefore(DateTime.now().add(Duration(days: 3))) ? savedDeadlines.preferenceDeadline : DateTime.now().add(Duration(days: 3));


    prefMax = deadlines.creationDeadline != null ? deadlines.creationDeadline.subtract(Duration(days: 3)) :
              deadlines.initiationDeadline != null ? deadlines.initiationDeadline.subtract(Duration(days: 6)) :
              DateTime.now().add(Duration(days: 365));
    
    creationMin = deadlines.preferenceDeadline != null ? deadlines.preferenceDeadline.add(Duration(days: 3)) :
                  DateTime.now().add(Duration(days: 6));
    
    creationMax = deadlines.initiationDeadline != null ? deadlines.initiationDeadline.subtract(Duration(days: 3)) :
                  DateTime.now().add(Duration(days: 365));
    
    initiationMin = deadlines.creationDeadline != null ? deadlines.creationDeadline.add(Duration(days: 3)) :
                    deadlines.preferenceDeadline != null ? deadlines.preferenceDeadline.add(Duration(days: 6)) :
                    DateTime.now().add(Duration(days: 9));
    
    initiationMax = DateTime.now().add(Duration(days: 365));
  }

  setScheduleValues() async {
    WebSocketRequest().setScheduleTemplate(await localDeadlines.getData.first);
  }
}