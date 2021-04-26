

import 'package:flutter/material.dart';
import 'package:schedule_application/AdministrationUIModule/Main/AdminRepository.dart';
import 'package:schedule_application_entities/DataObjects/ShiftTemplate.dart';


class ShiftsUI extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShiftTemplate>>(
      initialData: [],
      stream: AdminRepository().shifts.getData,
      builder: (BuildContext context, AsyncSnapshot<List<ShiftTemplate>> snapshot) {
        if(!snapshot.hasData) return Container();
        List<ShiftTemplate> shifts = snapshot.data;
        return ListView.builder(
          itemCount: shifts.length,
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
    );
  }
}
