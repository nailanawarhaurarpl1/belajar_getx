import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/modules/form/controllers/form_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; 
import '../views/output.dart';

class FormView extends GetView<FormController> {
  const FormView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Form'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                onChanged: (value) => controller.namalengkap.value = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                onChanged: (value) => controller.tempatlahir.value = value,
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => controller.selectDate(context),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(text: controller.selectedDate.value),
                  onTap: () => controller.selectDate(context),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => controller.email.value = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Negara'),
                onChanged: (value) => controller.negara.value = value,
              ),
              SizedBox(height: 16),
              Text('Pilih Jenis Member:'),
              SizedBox(height: 8),
              Obx(
                () => Wrap(
                  children: controller.memberList.map((memberType) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        label: Text(memberType),
                        selected: controller.selectedMember.value == memberType,
                        onSelected: (selected) =>
                            controller.toggleMember(memberType),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Kartu'),
                onChanged: (value) => controller.nomorkartu.value = value,
                style: TextStyle(fontSize: 16),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Expired',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => controller.selectDate(context, isExpiredDate: true),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: controller.tanggalExpired.value != null
                      ? DateFormat('yyyy-MM-dd').format(controller.tanggalExpired.value!)
                      : ''
                  ),
                  onTap: () => controller.selectDate(context, isExpiredDate: true),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Total Harga:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Obx(
                () => Text(
                  '${controller.totalHarga.value}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Detail Benefits:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Obx(
                () => Text(
                  '${getMembershipInfo()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Tambahkan properti fontWeight di sini
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {  
                  Get.to(() => OutputPage());
                },  
                child: Text('Submit'),
              ),
              Obx(
                () => controller.isFormSubmitted.value
                    ? Text('Formulir sudah disubmit!')
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getMembershipInfo() {
    String membershipInfo = '';
    switch (controller.selectedMember.value) {
      case 'Reguler':
        membershipInfo = 'Anggota 1 Bulan';
        break;
      case 'Gold':
        membershipInfo = 'Anggota 1 Bulan + Cemilan Gratis';
        break;
      case 'Platinum':
        membershipInfo = 'Anggota 2 Bulan + Cemilan Gratis + Free Wifi';
        break;
      case 'VIP':
        membershipInfo = 'Anggota 3 Bulan + Cemilan Gratis + Free Wifi + Tiket Konser';
        break;
      default:
        membershipInfo = '';
    }
    return membershipInfo;
  }
}