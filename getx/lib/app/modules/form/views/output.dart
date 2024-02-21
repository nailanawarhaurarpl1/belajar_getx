import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/modules/form/controllers/form_controller.dart';

class OutputPage extends StatelessWidget {
  final FormController formController = Get.find(); // Get the instance of FormController

  @override
  Widget build(BuildContext context) {
    // Menghitung umur berdasarkan tanggal lahir
    String calculateAge(DateTime birthDate) {
      final today = DateTime.now();
      final age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month &&
              today.day < birthDate.day)) {
        // Belum ulang tahun
        return (age - 1).toString();
      } else {
        return age.toString();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Output Data'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Judul')),
            DataColumn(label: Text('Data')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Nama Lengkap')),
              DataCell(Text(formController.namalengkap.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Tempat Lahir')),
              DataCell(Text(formController.tempatlahir.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Tanggal Lahir')),
              DataCell(Text(formController.tanggallahir.value != null
                  ? formController.tanggallahir.value.toString()
                  : '')),
            ]),
            DataRow(cells: [
              DataCell(Text('Umur')),
              DataCell(Text(formController.tanggallahir.value != null
                  ? calculateAge(formController.tanggallahir.value!)
                  : '')),
            ]),
            DataRow(cells: [
              DataCell(Text('Email')),
              DataCell(Text(formController.email.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Negara')),
              DataCell(Text(formController.negara.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Jenis Member')),
              DataCell(Text(formController.selectedMember.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Nomor Kartu')),
              DataCell(Text(formController.nomorkartu.value)),
            ]),
            DataRow(cells: [
              DataCell(Text('Tanggal Expired')),
              DataCell(Text(formController.tanggalExpired.value != null
                  ? formController.tanggalExpired.value!.toString()
                  : '')),
            ]),
            DataRow(cells: [
              DataCell(Text('Total Harga')),
              DataCell(Text(formController.totalHarga.value.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text('Detail Benefits')), // Tambahkan baris baru
              DataCell(Text(getBenefits())), // Tambahkan baris baru
            ]),
          ],
        ),
      ),
    );
  }

  String getBenefits() {
    String benefits = '';
    switch (formController.selectedMember.value) {
      case 'Reguler':
        benefits = 'Anggota 1 Bulan';
        break;
      case 'Gold':
        benefits = 'Anggota 1 Bulan + Cemilan Gratis';
        break;
      case 'Platinum':
        benefits = 'Anggota 2 Bulan + Cemilan Gratis + Free Wifi';
        break;
      case 'VIP':
        benefits = 'Anggota 3 Bulan + Cemilan Gratis + Free Wifi + Tiket Konser';
        break;
      default:
        benefits = 'Pilih Jenis Member';
    }
    return benefits;
  }
}