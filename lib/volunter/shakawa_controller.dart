import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintController extends GetxController {
  final teamNameController = TextEditingController();
  final complaintTypeController = TextEditingController();
  final descriptionController = TextEditingController();

  void sendComplaint() {
    if (teamNameController.text.isEmpty ||
        complaintTypeController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى تعبئة جميع الحقول',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      // هون ممكن تبعت البيانات للسيرفر مثلاً

      // بعدها نظف الحقول
      teamNameController.clear();
      complaintTypeController.clear();
      descriptionController.clear();

      Get.snackbar(
        'تم الإرسال',
        'تم إرسال الشكوى بنجاح ✅',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    teamNameController.dispose();
    complaintTypeController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
