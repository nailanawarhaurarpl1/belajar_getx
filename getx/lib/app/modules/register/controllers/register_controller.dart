import 'dart:convert';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/api.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;

  void onNameChanged(String value) {
    name.value = value;
  }

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  Future<void> register() async {
    try {
      var response = await _performRegistration();
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 ) {
        Get.snackbar(
          'Success', 
          'Registration Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
      } else {
        Get.snackbar(
          'Error', 'Registration failed. ${responseBody['message']}');
      }
    } catch (e) {
      print('Error during registration: $e');
      Get.snackbar('Error', 'An error occurred during registration.');
    }
  }

  Future<http.Response> _performRegistration() async {
    var apiUrl = '/api/register';
    var requestBody = {
      'name': name.value,
      'email': email.value,
      'password': password.value,
      'role': 'member'
    };

    return await http.post(
      Uri.parse(Api.baseUrl + apiUrl),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
  }

  void goToLogin() {
    Get.toNamed('/login');
  }
}
