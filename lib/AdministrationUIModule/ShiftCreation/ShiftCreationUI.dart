

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';
import 'ShiftsViewModel.dart';




class ShiftCreationUI extends StatefulWidget {

  @override
  _ShiftCreationUIState createState() => _ShiftCreationUIState();
}

class _ShiftCreationUIState extends State<ShiftCreationUI> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {MainViewModel().navigate();},),
        centerTitle: true,
        title: CustomTitleText(title: 'shift creation', fontSize: 24,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
        child: Column(
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomTimePicker(
                      title: 'start time',
                      time: ShiftsViewModel().startTime != null ? TimeOfDay.fromDateTime(ShiftsViewModel().startTime) : null,
                      color: Colors.blue,
                      onChanged: (string) => setState(()  => ShiftsViewModel().startTime = DateTime.parse('2000-01-01 ' + string + ':00')),
                      validator: (string) {
                        if(ShiftsViewModel().startTime == null) return "set time";
                        return null;
                      },
                    ),

                    SizedBox(height: 32,),

                    CustomTimePicker(
                      title: 'end time',
                      time: ShiftsViewModel().endTime != null ? TimeOfDay.fromDateTime(ShiftsViewModel().endTime) : null,
                      color: Colors.blue,
                      onChanged: (string) => setState(()  => ShiftsViewModel().endTime = DateTime.parse('2000-01-01 ' + string + ':00')),
                      validator: (string) => ShiftsViewModel().endTime == null ? "set time" : (ShiftsViewModel().startTime.hour*60+ShiftsViewModel().startTime.minute).compareTo(ShiftsViewModel().endTime.hour*60+ShiftsViewModel().endTime.minute) > 0 ? "must be after start time" : null,
                    ),

                    SizedBox(height: 32),

                    CustomDropDownButton(
                      title: 'weekday',
                      value: ShiftsViewModel().weekDay,
                      color: Colors.blue,
                      items: WeekDay.values.map<DropdownMenuItem<WeekDay>>((weekDay) => DropdownMenuItem(value: weekDay, child: Text(weekDay.toString().split(".").last),)).toList(),
                      onChanged: (weekDay) => setState(()  => ShiftsViewModel().weekDay = weekDay)
                    ),

                    SizedBox(height: 32),

                    CustomDropDownButton(
                      title: 'worker type',
                      value: ShiftsViewModel().workerType,
                      color: Colors.blue,
                      items: WorkerType.values.map<DropdownMenuItem<WorkerType>>((type) => DropdownMenuItem(value: type, child: Text(EnumToString.convertToString(type)))).toList(),
                      onChanged: (type) => setState(()  => ShiftsViewModel().workerType = type)
                    ),
                  ],
                ),

              ),

              SizedBox(height: 32,),

              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width*0.8,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextButton(
                      title: 'create shift'.toUpperCase(),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onClick: () async {
                        if(_formKey.currentState.validate()){
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("New Shift"),
                                  content: Text(ShiftsViewModel().weekDay.toString().replaceAll("WeekDay.","").toLowerCase() + ": " + ShiftsViewModel().startTime.toString().substring(11,16) + " - " + ShiftsViewModel().endTime.toString().substring(11,16)),
                                  actions: [
                                    TextButton(
                                      child: Text("create", style: TextStyle(fontSize: 16),),
                                      onPressed: () {
                                        ShiftsViewModel().addShift();
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              }
                          );
                        }},
                    )
                ),
              ),
            ])
      ),
    );
  }
}
