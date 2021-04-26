
import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/NavigationUI.dart';
import 'package:schedule_application/StructureModule/support/MainPage.dart';


import '../OffDayRequests/OffDayRequestUI.dart';
import '../Preferences/PreferenceUI.dart';
import '../Schedule/ScheduleUI.dart';
import '../ShiftChanges/ShiftChangeUI.dart';

class WorkerMainUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('WorkerMainUI - built');

    return NavigationUI(
      pages: [
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "schedule"
            ),
            page: ScheduleUI(),
            fabButton: null
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.wifi_protected_setup_rounded),
                label: "shift changes"
            ),
            page: ShiftChangeUI(),
            fabButton: null
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.tune_rounded),
                label: "preferences"
            ),
            page: PreferenceUI(),
            fabButton: null
        ),
        MainPage(
            barItem: BottomNavigationBarItem(
                icon: Icon(Icons.event_busy_rounded),
                label: "off days"
            ),
            page: OffDayRequestIU(),
            fabButton: null
        ),
      ]
    );
  }
}
