import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pandhu_putra_s/model/data_model.dart';

class DataController extends GetxController {
  var isLoading = false.obs;
  
  var listData = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      
      final url = Uri.parse("https://dummyjson.com/recipes");
      final response = await http.get(url);

      isLoading.value = false;

      if (response.statusCode == 200) {
        var result = recipeModelFromJson(response.body);
        
        if (result.recipes != null) {
          listData.assignAll(result.recipes!);
        }
        
        Get.snackbar("Berhasil", "Data resep berhasil dimuat dari API");
      } else {
        Get.snackbar("Gagal", "Terjadi kesalahan pada server");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      print("Error nya: " + e.toString());
    }
  }
}