


import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application/WorkerModule/Main/WorkerRepository.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';

import 'PreferenceViewModel.dart';

class PreferenceUI extends StatefulWidget {
  @override
  _PreferenceUIState createState() => _PreferenceUIState();
}

class _PreferenceUIState extends State<PreferenceUI> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(top: 32, right: 32, left: 32),
              child: StreamBuilder<List<ShiftTemplate>>(
                initialData: [],
                stream: WorkerRepository().shifts.getData,
                builder: (BuildContext context, AsyncSnapshot<List<ShiftTemplate>> snapshot) {
                  if(!snapshot.hasData) return Container();
                  List<ShiftTemplate> shifts = snapshot.data;
                  print(shifts.length);
                  return ListView.builder(
                    itemCount: shifts.length,
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      ShiftTemplate shift = shifts[index];
                      return ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.blue,),
                        title: Text(shift.weekDay.toString().split('.').last),
                        subtitle: Text(shift.startTime.hour.toString().padLeft(2,'0') + ':' + shift.startTime.minute.toString().padLeft(2,'0') + " - " + shift.endTime.hour.toString().padLeft(2,'0') + ":" + shift.endTime.minute.toString().padLeft(2,'0')),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey[300],),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 32, right: 32, left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDropDownButton(
                  title: 'preferred weekly shifts',
                  value: PreferenceViewModel().prefWeeklyShifts,
                  items: [1,2,3,4,5,6,7].map<DropdownMenuItem<int>>((int) => DropdownMenuItem(value: int, child: Text(int.toString()))).toList(),
                  onChanged: (duration){
                    setState(() {
                      PreferenceViewModel().prefWeeklyShifts = duration;
                    });
                  },
                ),
                Divider(height: 16,),
                CustomDropDownButton(
                  title: 'maximum weekly shifts',
                  value: PreferenceViewModel().maxWeeklyShifts,
                  items: [1,2,3,4,5,6,7].map<DropdownMenuItem<int>>((int) => DropdownMenuItem(value: int, child: Text(int.toString()))).toList(),
                  onChanged: (duration){
                    setState(() {
                      PreferenceViewModel().maxWeeklyShifts = duration;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

