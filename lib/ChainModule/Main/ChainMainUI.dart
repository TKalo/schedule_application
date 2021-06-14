

import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/NavigationUI.dart';
import 'package:schedule_application/StructureModule/support/MainPage.dart';

class ChainMainUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationUI(pages: [
      MainPage(
          barItem: BottomNavigationBarItem(
              icon: Icon(Icons.error),
              label: "off day requests"
          ),
          page: Container(key: ValueKey<int>(2),color:Colors.white),
      )
    ]);
  }
}
