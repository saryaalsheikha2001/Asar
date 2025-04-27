import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class detail_voulnter_controller extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var selectedProvince = ''.obs;
  var specializationController = TextEditingController();
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
    'حسكة',
    'السويداء',
    'درعا',
  ];

  Future pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) avatarPath.value = picked.path;
  }

  void save() {
    if (avatarPath.value.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'يرجى اختيار صورة شخصية',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (!formKey.currentState!.validate()) {
      // الفورم فيه أخطاء
      return;
    }

    if (selectedProvince.value.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'يرجى اختيار المحافظة',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // ✅ كل شيء صحيح، نحدث البيانات
    nameController.text = nameController.text.trim();
    phoneController.text = phoneController.text.trim();
    specializationController.text = specializationController.text.trim();
    selectedProvince.value = selectedProvince.value;
    avatarPath.value = avatarPath.value;

    // ✅ عرض رسالة نجاح
    Get.snackbar(
      'نجاح',
      'تم تحديث المعلومات بنجاح',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed('/buttom_navigation_bar_voulnter');
    });
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      nameController.text = args['name'] ?? '';
      phoneController.text = args['phone'] ?? ''; // أو حقل الهاتف لو مررته
    }
  }
}
