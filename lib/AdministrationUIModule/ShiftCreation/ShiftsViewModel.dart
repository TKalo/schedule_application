

import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';
class ShiftsViewModel {
  static final ShiftsViewModel _singleton = ShiftsViewModel._internal();

  factory ShiftsViewModel(){
    return _singleton;
  }

  ShiftsViewModel._internal();

  DateTime startTime;
  DateTime endTime;
  WeekDay weekDay = WeekDay.monday;
  WorkerType workerType = WorkerType.eighteen_plus;

  void addShift() async {
    MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);
  }
}