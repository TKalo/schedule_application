

import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';
import 'package:schedule_application_entities/DataObjects/UserCreationValues.dart';

class WorkerRepository{
  static final WorkerRepository _singleton = WorkerRepository._internal();
  factory WorkerRepository(){return _singleton;}
  WorkerRepository._internal();

  final UserCreationValues userCreationRequestValues = UserCreationValues();

  RxList<ShiftTemplate> shifts = RxList(startWith: []);
}