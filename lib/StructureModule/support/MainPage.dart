
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class MainPage{
  BottomNavigationBarItem barItem;
  Widget page;
  List<UnicornButton> fabButton;

  MainPage({@required this.barItem,@required this.page, this.fabButton});

}