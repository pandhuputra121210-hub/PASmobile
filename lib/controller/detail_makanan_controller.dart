import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailMakananController extends GetxController {
  var isLoading = false.obs;

  var namaMakanan = "".obs;
  var kategoriMakanan = "".obs;
  var gambarMakanan = "".obs;
  var deskripsiMakanan = "".obs;
  var hargaAwal = 0.0.obs;

  TextEditingController txtHargaAwal = TextEditingController();
  TextEditingController txtDiskon = TextEditingController();
  TextEditingController txtPajak = TextEditingController();

  var modeAktif = "".obs; 
  var nominalDiskon = 0.0.obs;
  var hargaSetelahDiskon = 0.0.obs;
  var nominalPajak = 0.0.obs;
  var totalSetelahPajak = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    var idMakanan = Get.arguments?['id'] ?? 1;
    fetchDetailMakanan(idMakanan);
  }

  void fetchDetailMakanan(dynamic id) async {
    try {
      isLoading.value = true;

      final url = Uri.parse("https://dummyjson.com/recipes/$id");
      final response = await http.get(url);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        namaMakanan.value = data['name'] ?? "Tanpa Nama";
        kategoriMakanan.value = data['cuisine'] ?? "Umum";
        gambarMakanan.value = data['image'] ?? "";
        
        double hargaDariApi = (data['price'] != null)
            ? double.parse(data['price'].toString())
            : (double.tryParse(data['caloriesPerServing'].toString()) ?? 250) * 100;

        hargaAwal.value = hargaDariApi;
        txtHargaAwal.text = hargaDariApi.toStringAsFixed(0);
      } else {
        Get.snackbar("Gagal", "Server error code: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Gagal", e.toString());
      print("Error detail makanan: $e");
    }
  }

  void hitungDiskon() {
    double harga = double.tryParse(txtHargaAwal.text) ?? 0;
    double persenDiskon = double.tryParse(txtDiskon.text) ?? 0;

    if (harga <= 0) {
      Get.snackbar("Error", "Harga awal tidak valid");
      return;
    }

    nominalDiskon.value = harga * (persenDiskon / 100);
    hargaSetelahDiskon.value = harga - nominalDiskon.value;
    modeAktif.value = "diskon";
  }

  void hitungPajak() {
    double harga = double.tryParse(txtHargaAwal.text) ?? 0;
    double persenPajak = double.tryParse(txtPajak.text) ?? 0;

    if (harga <= 0) {
      Get.snackbar("Error", "Harga awal tidak valid");
      return;
    }

    nominalPajak.value = harga * (persenPajak / 100);
    totalSetelahPajak.value = harga + nominalPajak.value;
    modeAktif.value = "pajak";
  }

  void resetHitungan() {
    txtDiskon.clear();
    txtPajak.clear();
    modeAktif.value = "";
    nominalDiskon.value = 0;
    hargaSetelahDiskon.value = 0;
    nominalPajak.value = 0;
    totalSetelahPajak.value = 0;
  }

  @override
  void onClose() {
    txtHargaAwal.dispose();
    txtDiskon.dispose();
    txtPajak.dispose();
    super.onClose();
  }
}