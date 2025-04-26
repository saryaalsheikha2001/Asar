import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login_volunter_controller extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      // منطق تحقق مزيف (مكان التحقق من قاعدة بيانات أو API)
      if (email == "volunteer@test.com" && password == "12345678") {
        Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح");
        // Get.offAllNamed('/homepage_voulnter');
        Get.offAllNamed('/buttom_navigation_bar_voulnter');
      } else {
        Get.snackbar(
          "فشل",
          "بيانات الدخول غير صحيحة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
