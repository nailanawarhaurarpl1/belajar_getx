import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Tugas1Controller extends GetxController {
  final int maxValue = 50; // Atur batas maksimum menjadi 50
  final int minValue = 1; // Atur batas minimum menjadi 1
  final count = 1.obs;
  final fontSize = 20.0.obs;

  void increment() {
    if (count.value < maxValue) {
      count.value++;
      fontSize.value += 1.0;
    } else {
      _showAlert('Tidak bisa ditambah, sudah batas maksimum');
    }
  }

  void decrement() {
    if (count.value > minValue) {
      count.value--;
      fontSize.value -= 1.0;
    } else {
      _showAlert('Tidak bisa dikurangi, sudah batas minimum');
    }
  }

  void _showAlert(String message) {
    Get.defaultDialog(
      title: 'Peringatan',
      content: Text(message),
      titleStyle: TextStyle(color: Colors.red),
      confirmTextColor: Colors.white,
      backgroundColor: Colors.white,
    );

    // Hapus pesan alert setelah 5 detik
    Future.delayed(Duration(seconds: 5), () {
      Get.back(); // Menghilangkan dialog
    });
  }
}
