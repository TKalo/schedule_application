

import 'package:flutter/material.dart';
import 'package:schedule_application/AdministrationUIModule/ShiftCreation/ShiftCreationUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/NavigationUI.dart';
import 'package:schedule_application/StructureModule/support/MainPage.dart';
import 'package:unicorndial/unicorndial.dart';

import '../ScheduleDeadline/ScheduleDeadlineUI.dart';
import '../ShiftCreation/ShiftsUI.dart';
import 'AdminDrawer.dart';

class AdminMainUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NavigationUI(
      pages: [
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "off day requests"
            ),
            page: Container(key: ValueKey<int>(2),color:Colors.white),
            fabButton: null
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.error_outline_rounded),
                label: "schedule issues"
            ),
            page: Container(key: ValueKey<int>(2),color:Colors.white),
            fabButton: null
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "shifts"
            ),
            page: ShiftsUI(),
            fabButton: [UnicornButton(
              currentButton: FloatingActionButton(
                onPressed: () {MainViewModel().navigate(location: ShiftCreationUI());},
                child: Icon(Icons.add),
              ),),],
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.tune_rounded),
                label: "schedule values"
            ),
            page: ScheduleDeadlineUI(),
            fabButton: null
        ),
      ],
      drawer: AdminDrawer(),
    );
  }
}
