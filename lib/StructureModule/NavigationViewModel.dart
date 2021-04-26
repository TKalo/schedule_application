import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application/StructureModule/support/MainPage.dart';

import 'MainViewModel.dart';



class NavigationViewModel {
  static final NavigationViewModel _singleton = NavigationViewModel._internal();
  factory NavigationViewModel(){return _singleton;}
  NavigationViewModel._internal();

  List<MainPage> pages;
  Widget drawer;
  RxValue<MainPage> currentPage = RxValue();


  List<BottomNavigationBarItem> getNavigationItems(){
    List<BottomNavigationBarItem> items = pages.map<BottomNavigationBarItem>((MainPage page) => page.barItem).toList();
    if(drawer != null) items.add(BottomNavigationBarItem(icon: Icon(Icons.menu), label: "extra"));
    return items;
  }

  void Function(int index) getNavigationHandler(){
    return (index){
      if(drawer != null && index == pages.length) MainViewModel().drawerState(true);
      else currentPage.setData(pages[index]);
    };
  }
}