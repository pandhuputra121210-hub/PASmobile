import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandhu_putra_s/routes.dart';
import 'package:pandhu_putra_s/controller/data_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Resep Makanan")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Obx(
          () => SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dataController.listData.length,
              itemBuilder: (context, index) {
                final recipe = dataController.listData[index];

                return InkWell(
                  onTap: () {
                    
                    Get.toNamed(
                      Routes.detail_makanan,
                      arguments: {
                        "id": recipe.id,
                        "name": recipe.name,
                        "image": recipe.image,
                        "cuisine": recipe.cuisine,
                      },
                    );
                  },
                  child: Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 200,
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            recipe.image!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.name!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Kategori: ${recipe.cuisine!}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },  
            ),
          ),
        ),
      ),
    );
  }
}