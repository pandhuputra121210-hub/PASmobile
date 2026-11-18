import 'package:flutter/material.dart';
import 'package:pandhu_putra_s/controller/list_makanan_controller.dart';
import 'package:pandhu_putra_s/routes.dart';
import 'package:get/get.dart';

class ListMakananPage extends StatelessWidget {
  ListMakananPage({super.key});

  final controller = Get.put(ListMakananController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Makanan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Obx(() {
        // Tampilkan indikator loading jika data sedang ditarik dari URL API
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Tampilkan pesan jika data kosong
        if (controller.listMakanan.isEmpty) {
          return const Center(child: Text("Tidak ada data makanan tersedia."));
        }

        return Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: controller.listMakanan.length,
            itemBuilder: (context, index) {
              final makanan = controller.listMakanan[index];
              return Dismissible(
                key: ValueKey(makanan.namaMakanan + index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  controller.listMakanan.removeAt(index);
                  Get.snackbar("Dihapus", "${makanan.namaMakanan} dihapus dari daftar");
                },
                child: InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail / kalkulator diskon pajak dengan membawa data
                    Get.toNamed(
                      Routes.detail_makanan,
                      arguments: {
                        'namaMakanan': makanan.namaMakanan,
                        'deskripsiMakanan': makanan.deskripsi,
                        'gambarMakanan': makanan.imageUrl,
                        'hargaMakanan': makanan.hargaMakanan,
                        'ratingMakanan': 5.0,
                      },
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: makanan.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  makanan.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.fastfood, size: 40),
                                ),
                              )
                            : const Icon(Icons.fastfood, size: 40),
                        title: Text(
                          makanan.namaMakanan,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${makanan.hargaMakanan}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}