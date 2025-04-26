import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var selectedTeam = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var obscurePassword = true.obs;
  TextEditingController emailTextEditingController = TextEditingController();

  final List<String> teams = ["فريق التميز", "فريق سند", "فريق عمرها"];
  final box = GetStorage();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    EmailValidatorFlutter emailValidatorFlutter = EmailValidatorFlutter();
    if (!emailValidatorFlutter.validateEmail(emailTextEditingController.text)) {
      Get.snackbar(
        "خطأ",
        "يرجى إدخال بريد إلكتروني صالح",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.value.length < 8) {
      Get.snackbar(
        "خطأ",
        "كلمة المرور يجب أن تكون 8 محارف على الأقل",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print('Team: ${selectedTeam.value}');
    print('Email: ${email.value}');
    print('Password: ${password.value}');

    box.write("isLoggedIn", true);
    // Get.offAllNamed("/Homepageadmin"); // إغلاق جميع الصفحات السابقة
    Get.offAllNamed("/buttom/navigation/bar/page");
  }
}
