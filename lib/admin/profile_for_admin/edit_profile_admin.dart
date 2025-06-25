import 'package:athar_project/admin/profile_for_admin/%D9%90Admin_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAdminProfilePage extends StatelessWidget {
  final controller = Get.find<AdminProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تعديل المعلومات",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
      ),
      body: GetBuilder<AdminProfileController>(
        init: AdminProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildImagePicker(),
                const SizedBox(height: 20),
                _textField("الاسم الكامل", controller.nameController),
                _textField("البريد الإلكتروني", controller.emailController),
                _textField("الرقم الوطني", controller.nationalController),
                _textField("الوظيفة", controller.positionController),
                _textField("رقم الهاتف", controller.phoneController),
                _textField("العنوان", controller.addressController),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
                  ),
                  onPressed: () {
                    if (_validateInputs()) {
                      controller.updateProfileInfo(
                        fullName: controller.nameController.text,
                        email: controller.emailController.text,
                        nationalNumber: controller.nationalController.text,
                        position: controller.positionController.text,
                        phone: controller.phoneController.text,
                        address: controller.addressController.text,
                        dateAccession:
                            controller.profileAdminModel.data!.dateAccession!,
                      );
                    }
                  },
                  child: const Text(
                    "حفظ التعديلات",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage:
              controller.pickedImage != null
                  ? FileImage(controller.pickedImage)
                  : (controller.profile.image != null &&
                      controller.profile.image!.isNotEmpty)
                  ? NetworkImage(controller.profile.image!)
                  : const AssetImage(
                        "assets/images/photo_2025-04-16_14-38-02-removebg-preview.png",
                      )
                      as ImageProvider,
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () => controller.pickImage(),
          icon: const Icon(Icons.image),
          label: const Text("تغيير الصورة"),
        ),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (controller.nameController.text.isEmpty ||
        controller.emailController.text.isEmpty ||
        controller.nationalController.text.isEmpty ||
        controller.positionController.text.isEmpty ||
        controller.phoneController.text.isEmpty ||
        controller.addressController.text.isEmpty) {
      Get.snackbar(
        "خطأ في الإدخال",
        "جميع الحقول مطلوبة، الرجاء تعبئتها.",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}
