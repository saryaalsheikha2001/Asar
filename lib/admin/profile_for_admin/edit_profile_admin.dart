import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final pickedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage.value = File(picked.path);
    }
  }

  void updateProfile() {
    final name = fullNameController.text.trim();
    final phone = phoneNumberController.text.trim();
    final password = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      _showError("الاسم الكامل مطلوب");
      return;
    }

    if (!phone.startsWith("+963") || phone.length < 10) {
      _showError("رقم الهاتف غير صالح");
      return;
    }

    if (password.isNotEmpty && password.length < 6) {
      _showError("كلمة المرور يجب أن تكون على الأقل 6 محارف");
      return;
    }

    if (password != confirmPassword) {
      _showError("كلمتا المرور غير متطابقتين");
      return;
    }

    Get.snackbar(
      "نجاح",
      "تم تحديث المعلومات بنجاح",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showError(String message) {
    Get.snackbar(
      "خطأ",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 51, 102, 1),
        title: Text(
          'آثر',
          style: TextStyle(color: Color.fromRGBO(217, 217, 217, 1)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // صورة الملف الشخصي
            Obx(
              () => GestureDetector(
                onTap: controller.pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          controller.pickedImage.value != null
                              ? FileImage(controller.pickedImage.value!)
                              : null,
                      child:
                          controller.pickedImage.value == null
                              ? Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey[700],
                              )
                              : null,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFF0D47A1),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // الاسم
            TextField(
              controller: controller.fullNameController,
              decoration: InputDecoration(
                labelText: 'الاسم الكامل',
                hintText: 'ادخل اسمك الكامل هنا',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),

            // رقم الهاتف
            TextField(
              controller: controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف المحمول',
                hintText: '+963...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),

            // كلمة المرور الجديدة
            TextField(
              controller: controller.newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),

            // تأكيد كلمة المرور
            TextField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 30),

            // زر التحديث
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.updateProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF0D47A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'تعديل المعلومات',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
