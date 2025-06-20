import 'dart:io';
import 'package:athar_project/admin/profile_for_admin/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../core/model/login_admin_model.dart';

class AdminProfileController extends GetxController {
  var profile = Rxn<Employee>();
  var pickedImage = Rx<File?>(null);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final nationalController = TextEditingController();
  final positionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    profile.value = Employee(
      id: 1,
      fullName: "د. أحمد خالد",
      email: "ahmad@example.com",
      nationalNumber: "123456789",
      position: "مشرف طبي",
      phone: "0944000000",
      address: "دمشق - المزة",
      image: "",
      team: 1,
      specialization: 1,
    );

    nameController.text = profile.value?.fullName ?? '';
    emailController.text = profile.value?.email ?? '';
    nationalController.text = profile.value?.nationalNumber ?? '';
    positionController.text = profile.value?.position ?? '';
    phoneController.text = profile.value?.phone ?? '';
    addressController.text = profile.value?.address ?? '';
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage.value = File(picked.path);
    }
  }

  void updateProfileInfo({
    required String fullName,
    required String email,
    required String nationalNumber,
    required String position,
    required String phone,
    required String address,
    required String dateAccession,
  }) async {
    // التحقق من ملء كل الحقول
    if (fullName.isEmpty || email.isEmpty || nationalNumber.isEmpty || position.isEmpty ||
        phone.isEmpty || address.isEmpty || dateAccession.isEmpty) {
      _showError("يرجى ملء جميع الحقول قبل الحفظ");
      return;
    }

    if (!phone.startsWith("09") || phone.length != 10) {
      _showError("رقم الهاتف يجب أن يبدأ بـ 09 ويتكون من 10 أرقام");
      return;
    }

    final updatedEmployee = Employee(
      id: profile.value!.id,
      fullName: fullName,
      email: email,
      nationalNumber: nationalNumber,
      position: position,
      phone: phone,
      address: address,
      image: pickedImage.value?.path ?? profile.value!.image,
      team: profile.value!.teamId,
      specialization: profile.value!.specializationId,
    );

    final success = await EmployeeService.updateEmployee(updatedEmployee);
    if (success) {
      profile.value = updatedEmployee;
      update();
      Get.back();
      Get.snackbar(
        "نجاح",
        "تم تحديث المعلومات بنجاح",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _showError("فشل في تحديث البيانات. حاول لاحقاً.");
    }
  }

  void _showError(String message) {
    Get.snackbar(
      "خطأ",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
