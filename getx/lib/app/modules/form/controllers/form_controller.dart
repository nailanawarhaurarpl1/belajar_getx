import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormController extends GetxController {
  var namalengkap = ''.obs;
  var tempatlahir = ''.obs;
  var tanggallahir = Rxn<DateTime>(); // Ubah menjadi Rxn<DateTime>
  var umur = ''.obs; // Tambahkan variabel umur
  var email = ''.obs;
  var negara = ''.obs;
  var nomorkartu = ''.obs;
  var tanggalExpired = Rxn<DateTime>(); 

  final List<String> memberList = [
    'Reguler',
    'Gold',
    'Platinum',
    'VIP',
  ];

  var selectedMember = ''.obs;
  var totalHarga = 0.0.obs; 

  List<String> getMemberList() => memberList;

  var isFormSubmitted = false.obs;
  var selectedDate = ''.obs;

  Future<void> selectDate(BuildContext context, {bool isExpiredDate = false}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    if (isExpiredDate) {
      tanggalExpired.value = picked; // Set the value of the expired date
    } else {
      selectedDate.value = formattedDate; // Set the value of the selected date
      tanggallahir.value = picked; // Set the value of the date of birth
      calculateAge(); // Calculate age after setting the date of birth
    }
  }
}


  void toggleMember(String memberValue) {
    selectedMember.value = memberValue;
    totalHarga.value = TotalHarga(); 
  }

  double TotalHarga() {
    switch (selectedMember.value) {
      case 'Reguler':
        return 50000.0;
      case 'Gold':
        return 150000.0;
      case 'Platinum':
        return 250000.0;
      case 'VIP':
        return 500000.0;
      default:
        return 0.0;
    }
  }

  void submitForm() {
    print(
        'Data Formulir: $namalengkap, $tempatlahir, $tanggallahir, $email, $negara, ${selectedMember.value}, Total Harga: ${totalHarga.value}, $nomorkartu, $tanggalExpired');
    isFormSubmitted.value = true;
  }

  void calculateAge() {
    if (tanggallahir.value != null) {
      final today = DateTime.now();
      final age = today.year - tanggallahir.value!.year;
      if (today.month < tanggallahir.value!.month ||
          (today.month == tanggallahir.value!.month &&
              today.day < tanggallahir.value!.day)) {
        umur.value = (age - 1).toString();
      } else {
        umur.value = age.toString();
      }
    } else {
      umur.value = '';
    }
  }
}
