import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandhu_putra_s/controller/detail_makanan_controller.dart';

class DetailMakananPage extends StatelessWidget {
  DetailMakananPage({super.key});

  final DetailMakananController controller = Get.put(DetailMakananController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail & Kalkulator Makanan"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        // Tampilkan loading saat sedang mengambil data dari URL API
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- BAGIAN 1: INFO DETAIL MAKANAN DARI API ---
              if (controller.gambarMakanan.value.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    controller.gambarMakanan.value,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.fastfood, size: 60),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                controller.namaMakanan.value,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "Kategori: ${controller.kategoriMakanan.value}",
                style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w600),
              ),
              const Divider(height: 28),

              // --- BAGIAN 2: INPUT HARGA & PERSENTASE ---
              TextField(
                controller: controller.txtHargaAwal,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga Awal Makanan (Rp)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.txtDiskon,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Diskon (%)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.discount),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller.txtPajak,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Pajak (%)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_balance),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- BAGIAN 3: DUA BUTTON AKSI TERPISAH ---
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.hitungDiskon,
                      icon: const Icon(Icons.discount),
                      label: const Text("Hitung Diskon"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.hitungPajak,
                      icon: const Icon(Icons.account_balance),
                      label: const Text("Hitung Pajak"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: controller.resetHitungan,
                child: const Text("Reset"),
              ),
              const SizedBox(height: 20),

              // --- BAGIAN 4: HASIL PERHITUNGAN ---
              if (controller.modeAktif.value.isNotEmpty)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.modeAktif.value == "diskon"
                              ? "Rincian Diskon (${controller.namaMakanan.value})"
                              : "Rincian Pajak (${controller.namaMakanan.value})",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Divider(height: 20),
                        _buildRow("Harga Awal", "Rp ${controller.txtHargaAwal.text}", Colors.black87),
                        const SizedBox(height: 8),
                        if (controller.modeAktif.value == "diskon") ...[
                          _buildRow(
                            "Potongan Diskon",
                            "- Rp ${controller.nominalDiskon.value.toStringAsFixed(0)}",
                            Colors.green,
                          ),
                          const Divider(height: 20),
                          _buildRow(
                            "Harga Setelah Diskon",
                            "Rp ${controller.hargaSetelahDiskon.value.toStringAsFixed(0)}",
                            Colors.blueAccent,
                            isBold: true,
                            fontSize: 18,
                          ),
                        ],
                        if (controller.modeAktif.value == "pajak") ...[
                          _buildRow(
                            "Nominal Pajak",
                            "+ Rp ${controller.nominalPajak.value.toStringAsFixed(0)}",
                            Colors.redAccent,
                          ),
                          const Divider(height: 20),
                          _buildRow(
                            "Total Setelah Pajak",
                            "Rp ${controller.totalSetelahPajak.value.toStringAsFixed(0)}",
                            Colors.blueAccent,
                            isBold: true,
                            fontSize: 18,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRow(String label, String value, Color color, {bool isBold = false, double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(
          value,
          style: TextStyle(fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: color),
        ),
      ],
    );
  }
}