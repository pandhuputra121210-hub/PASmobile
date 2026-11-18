import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pandhu_putra_s/pages/login_page.dart';
import 'package:pandhu_putra_s/pages/main_menu_page.dart';
import 'package:pandhu_putra_s/pages/list_makanan_page.dart';
import 'package:pandhu_putra_s/pages/detail_makanan.page.dart';

class Routes {
  static const String login = '/login';
  static const String main_menu = '/main_menu';
  static const String list_makanan = '/list_makanan';
  static const String detail_makanan = '/detail_makanan';

  static final myPages = [
     GetPage(name: login, page: () => LoginPage()),
      GetPage(name: main_menu, page: () => MainMenuPage()),
      GetPage(name: list_makanan, page: () => ListMakananPage()),
      GetPage(name: detail_makanan, page: () => DetailMakananPage()),
  ];






}
