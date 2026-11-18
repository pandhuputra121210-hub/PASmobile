import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandhu_putra_s/routes.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {


  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  var isLoading = false.obs;

  void login() async {
    if (txtUsername.text.toString().isEmpty || txtPassword.text.toString().isEmpty) {
      Get.snackbar("Error", "Username dan password harus terisi");
    } else {
      try {
        
        isLoading.value = true;
        
       
        final url = Uri.parse("https://mediadwi.com/api/latihan/login"); 

        
        final response = await http.get(url);

        
        isLoading.value = false;
        
        
        if (response.statusCode == 200) {
          Get.snackbar("Berhasil", "Login Berhasil, Memuat Halaman...");
          

          Get.offNamed(Routes.main_menu);

        } else {
          Get.snackbar("Gagal", "Server error code: ${response.statusCode}");
        }

      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Gagal", e.toString());
        print("Error nya: " + e.toString());
      }
    }
  }
}