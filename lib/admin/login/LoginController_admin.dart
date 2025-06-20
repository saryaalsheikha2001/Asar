import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/admin/core/model/login_admin_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var selectedTeam = '';
  final passwordController = TextEditingController();
  var obscurePassword = true;
  TextEditingController emailTextEditingController = TextEditingController();

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  final List<String> teams = ["فريق التميز", "فريق سند", "فريق عمرها"];
  final box = GetStorage();

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  Future<dynamic> login() async {
    // if (formKey.currentState!.validate()) {
    try {
      isLoadingSet(true);
      var storage = Get.find<StorageService>();
      final http.Response response = await NetworkUtils.post(
        url: "employee/login",

        headers: NetworkUtils.headers,
        body: json.encode({
          "email": emailTextEditingController.text,
          "password": passwordController.text,
        }),
      );
      log(response.body.toString(), name: "login response body");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح");
        storage.storeEmployeeTokenInfo(
          LoginAdminModel.fromJson(json.decode(response.body)),
        );
        storage.setLoginAccountType(true);
        Get.offAllNamed('/buttom/navigation/bar/page');
      } else {
        Get.snackbar(
          "فشل",
          "بيانات الدخول غير صحيحة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log(e.toString(), name: "login catch error");
    } finally {
      isLoadingSet(false);
    }
    // }
  }

  // void login() {
  //   EmailValidatorFlutter emailValidatorFlutter = EmailValidatorFlutter();
  //   if (!emailValidatorFlutter.validateEmail(emailTextEditingController.text)) {
  //     Get.snackbar(
  //       "خطأ",
  //       "يرجى إدخال بريد إلكتروني صالح",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }

  //   if (password.length < 8) {
  //     Get.snackbar(
  //       "خطأ",
  //       "كلمة المرور يجب أن تكون 8 محارف على الأقل",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }

  //   print('Team: ${selectedTeam}');
  //   print('Email: ${email}');
  //   print('Password: ${password}');

  //   box.write("isLoggedIn", true);
  //   // Get.offAllNamed("/Homepageadmin"); // إغلاق جميع الصفحات السابقة
  //   Get.offAllNamed("/buttom/navigation/bar/page");
  // }
}
