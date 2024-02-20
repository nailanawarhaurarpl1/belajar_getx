import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/biodata_controller.dart';
import 'package:intl/intl.dart';

class BiodataView extends StatelessWidget {
  BiodataView({Key? key}) : super(key: key);

  final BiodataController biodataController = BiodataController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiodataView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nama'),
                      onChanged: (value) =>
                          biodataController.nama.value = value,
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () =>
                          biodataController.selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          hintText: 'Pilih Tanggal',
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tanggal Lahir:'),
                            Obx(() => Text(
                                biodataController.selectedDate.value)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField(
                      items: [
                        'Islam',
                        'Kristen',
                        'Hindu',
                        'Buddha',
                        'Lainnya'
                      ]
                          .map((agama) => DropdownMenuItem(
                              value: agama, child: Text(agama)))
                          .toList(),
                      onChanged: (value) =>
                          biodataController.agama.value = value.toString(),
                      decoration: InputDecoration(labelText: 'Agama'),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Obx(() => Radio(
                            value: 'Laki-Laki',
                            groupValue:
                                biodataController.jenisKelamin.value,
                            onChanged: (value) =>
                                biodataController.jenisKelamin.value = value
                                    .toString())),
                        Text('Laki-Laki'),
                        Obx(() => Radio(
                            value: 'Perempuan',
                            groupValue:
                                biodataController.jenisKelamin.value,
                            onChanged: (value) =>
                                biodataController.jenisKelamin.value = value
                                    .toString())),
                        Text('Perempuan'),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(labelText: 'Alamat'),
                      onChanged: (value) =>
                          biodataController.alamat.value = value,
                    ),
                    SizedBox(height: 16.0),
                    for (String hobi in biodataController.getHobiList())
                      Obx(() => CheckboxListTile(
                            title: Text(hobi),
                            value: biodataController.hobi.contains(hobi),
                            onChanged: (value) =>
                                biodataController.toggleHobi(hobi),
                          )),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _showAlert(context),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Obx(() {
                if (biodataController.isFormSubmitted.value) {
                  return Text(
                    'Output: ${biodataController.nama}, ${biodataController.tanggalLahir}, ${biodataController.agama}, ${biodataController.jenisKelamin}, ${biodataController.alamat}, ${biodataController.hobi}',
                    style: TextStyle(fontSize: 16.0),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Biodata Anda'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nama: ${biodataController.nama.value}'),
                Text('Tanggal Lahir: ${biodataController.selectedDate.value}'),
                Text('Agama: ${biodataController.agama.value}'),
                Text('Jenis Kelamin: ${biodataController.jenisKelamin.value}'),
                Text('Alamat: ${biodataController.alamat.value}'),
                Text('Hobi: ${biodataController.hobi}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
