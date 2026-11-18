import 'package:flutter/material.dart';
import 'package:pandhu_putra_s/routes.dart';
import 'package:pandhu_putra_s/main.dart';
import 'package:pandhu_putra_s/pages/login_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Learning App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: Routes.myPages,
    );
  }
}