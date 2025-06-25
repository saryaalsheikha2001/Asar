// import 'dart:io';
// import 'package:athar_project/admin/core/model/login_admin_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class AdminProfileController extends GetxController {
//   var profile = Rxn<Employee>();
//   var pickedImage = Rxn<File>();

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final nationalController = TextEditingController();
//   final positionController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     profile.value = Get.arguments as Employee;

//     nameController.text = profile.value?.fullName ?? '';
//     emailController.text = profile.value?.email ?? '';
//     nationalController.text = profile.value?.nationalNumber ?? '';
//     positionController.text = profile.value?.position ?? '';
//     phoneController.text = profile.value?.phone ?? '';
//     addressController.text = profile.value?.address ?? '';
//   }

//   void pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       pickedImage.value = File(picked.path);
//       update(); // لتحديث الصورة في الواجهة
//     }
//   }

//   void updateProfileInfo({
//     required String fullName,
//     required String email,
//     required String nationalNumber,
//     required String position,
//     required String phone,
//     required String address,
//     required String dateAccession,
//   }) {
//     // هنا يتم التعديل داخل النموذج المحلي فقط، يمكنك لاحقًا ربطها بـ API

//     Get.back(result: profile.value); // ترجع البيانات بعد التعديل
//   }
// }
