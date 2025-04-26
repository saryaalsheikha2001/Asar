import 'package:athar_project/volunter/details_about_voulnter/details_voulnter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class sinup_voulnter_controller extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void register() {
    if (formKey.currentState!.validate()) {
      Get.off(
        () => detail_voulnter(),
        arguments: {'name': nameController.text, 'email': emailController.text},
      );
    }
  }
}

//   void register() {
//     if (formKey.currentState!.validate()) {
//       // بعد تحقق البيانات وإنشاء الحساب بنجاح:
//       Get.off(
//         () => detail_voulnter(),
//         arguments: {
//           'name': nameController.text,
//           'email': emailController.text,
//           // إذا في حقول إضافية تمررهم هنا
//         },
//       );
//     }
//   }
// }
