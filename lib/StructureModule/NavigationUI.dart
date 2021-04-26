

import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/MainPage.dart';
import 'package:unicorndial/unicorndial.dart';
import 'MainViewModel.dart';
import 'NavigationViewModel.dart';

class NavigationUI extends StatelessWidget {

  NavigationUI({@required List<MainPage> pages, Widget drawer}){
    viewModel.pages = pages;
    viewModel.drawer = drawer;
  }

  final NavigationViewModel viewModel = NavigationViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: MainViewModel().scaffoldKey,
        body: StreamBuilder<MainPage>(
          stream: viewModel.currentPage.getData,
          builder: (context, snapshot){
            return AnimatedSwitcher(
              child: snapshot.hasData && snapshot.data.page != null ? snapshot.data.page : Container() ,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),

        bottomNavigationBar: StreamBuilder<MainPage>(
            stream: viewModel.currentPage.getData,
            builder: (context, snapshot) {
              return BottomNavigationBar(
                backgroundColor: Colors.red.withOpacity(0.1),
                items: viewModel.getNavigationItems(),
                currentIndex: snapshot.hasData ? viewModel.pages.indexOf(snapshot.data) : 0,
                selectedItemColor: Colors.red[700],
                unselectedItemColor: Colors.orange[500],
                onTap: viewModel.getNavigationHandler(),
              );
            }
        ),

        floatingActionButton: StreamBuilder<MainPage>(
            stream: viewModel.currentPage.getData,
            builder: (context, snapshot) {
              return snapshot.hasData && snapshot.data.fabButton != null ? UnicornDialer(
                parentButton: Icon(Icons.more_horiz_rounded, color: Colors.grey[500],),
                parentButtonBackground: Colors.grey[300],
                orientation: UnicornOrientation.VERTICAL,
                childButtons: snapshot.data.fabButton,
              ) : Container();
            }
        ),

        endDrawer: viewModel.drawer,
      ),

      onWillPop: () async {
        return false;
      },
    );
  }
}
