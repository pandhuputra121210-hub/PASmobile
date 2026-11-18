import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class MakananModel {
  final String namaMakanan;
  final String deskripsi;
  final String imageUrl;
  final String hargaMakanan;

  MakananModel({
    required this.namaMakanan,
    required this.deskripsi,
    required this.imageUrl,
    required this.hargaMakanan,
  });

  factory MakananModel.fromJson(Map<String, dynamic> json) {
    double dummyHarga = (json['caloriesPerServing'] != null) 
        ? double.parse(json['caloriesPerServing'].toString()) * 100 
        : 25000;

    return MakananModel(
      namaMakanan: json['name'] ?? 'Menu Tanpa Nama',
      deskripsi: json['cuisine'] ?? 'Kategori Umum',
      imageUrl: json['image'] ?? '',
      hargaMakanan: dummyHarga.toStringAsFixed(0),
    );
  }
}

class ListMakananController extends GetxController {
  var isLoading = false.obs;
  var listMakanan = <MakananModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataMakanan();
  }

  void fetchDataMakanan() async {
    try {
      isLoading.value = true;
      
      final url = Uri.parse("https://dummyjson.com/recipes");
      final response = await http.get(url);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List recipes = data['recipes'] ?? [];

        listMakanan.value = recipes.map((item) => MakananModel.fromJson(item)).toList();
      } else {
        Get.snackbar("Gagal", "Gagal memuat data, status: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      print("Error fetch makanan: $e");
    }
  }
}