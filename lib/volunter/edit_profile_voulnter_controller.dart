import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileVoulnterController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final specializationController = TextEditingController();

  var selectedProvince = ''.obs;
  var avatarPath = ''.obs;

  final List<String> provinces = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'إدلب',
    'اللاذقية',
    'طرطوس',
    'دير الزور',
    'الرقة',
    'الحسكة',
    'السويداء',
    'درعا',
  ];

  final formKey = GlobalKey<FormState>();

  void saveProfile() {
    if (formKey.currentState!.validate() && selectedProvince.isNotEmpty) {
      Get.snackbar(
        'نجاح',
        'تم حفظ المعلومات بنجاح ✅',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back(); // يرجع مباشرة بدون انتظار
    } else {
      Get.snackbar(
        'تنبيه',
        'يرجى تعبئة جميع الحقول',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
