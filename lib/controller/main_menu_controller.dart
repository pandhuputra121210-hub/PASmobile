import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandhu_putra_s/menu/feet.dart';
import 'package:pandhu_putra_s/menu/home.dart';
import 'package:pandhu_putra_s/menu/profile.dart';

class MainMenuController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }


  List<Widget> listPages = [
    HomePage(),
    FeetPage(),
    ProfilePage(), 
  ];
}