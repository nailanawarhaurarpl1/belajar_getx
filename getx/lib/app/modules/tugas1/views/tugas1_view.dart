import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tugas1_controller.dart';
import '../../home/views/home_view.dart'; // Import HomeView

class Tugas1View extends GetView<Tugas1Controller> {
  const Tugas1View({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas1View'),
        centerTitle: true,
        leading: IconButton( // Tombol di pojok kiri atas
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(HomeView()); // Pergi ke HomeView
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisikan widget di tengah secara vertikal
          children: [
            Obx(() {
              return Text(
                '${controller.count}',
                style: TextStyle(fontSize: controller.fontSize.value), // Gunakan nilai fontsize dari controller
              );
            }),
            SizedBox(height: 20), // Spasi antara teks dan tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Posisikan widget di tengah secara horizontal
              children: [
                FloatingActionButton(
                  onPressed: () {
                    controller.decrement(); // Panggil fungsi decrement
                  },
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    controller.increment();
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
