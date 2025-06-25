import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/admin/buttom_navigation_bar/buttom_navigation_bar_page.dart';
import 'package:athar_project/admin/profile_for_admin/admin_service.dart';
import 'package:athar_project/admin/profile_for_admin/profile_admin_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../core/model/login_admin_model.dart';

class AdminProfileController extends GetxController {
  var profile = Employee();
  File pickedImage = File('');

  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final nationalController = TextEditingController();
  final positionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();

  ProfileAdminModel profileAdminModel = ProfileAdminModel();

  Future<ProfileAdminModel> getProfile() async {
    try {
      isLoading = true;
      update();
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "employee/profile",
        headers: authHeaders,
      );
      log(
        response.statusCode.toString(),
        name: "getProfile response statusCode",
      );
      log(response.body.toString(), name: "getProfile response body");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        profileAdminModel = ProfileAdminModel.fromJson(data);
        return ProfileAdminModel.fromJson(data);
      }
      return ProfileAdminModel();
    } catch (e) {
      log(e.toString(), name: "getProfile catch error");
      return ProfileAdminModel();
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  Future onInit() async {
    super.onInit();
    await getProfile();
    loadProfileData();
  }

  void loadProfileData() {
    // profile = Employee(
    //   id: 1,
    //   fullName: "د. أحمد خالد",
    //   email: "ahmad@example.com",
    //   nationalNumber: "123456789",
    //   position: "مشرف طبي",
    //   phone: "0944000000",
    //   address: "دمشق - المزة",
    //   image: "",
    //   team: 1,
    //   specialization: 1,
    // );

    nameController.text = profileAdminModel.data!.fullName ?? '';
    emailController.text = profileAdminModel.data!.email ?? '';
    nationalController.text = profileAdminModel.data!.nationalNumber ?? '';
    positionController.text = profileAdminModel.data!.position ?? '';
    phoneController.text = profileAdminModel.data!.phone ?? '';
    addressController.text = profileAdminModel.data!.address ?? '';
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage = File(picked.path);
    }
  }

  void updateProfileInfo({
    required String fullName,
    required String email,
    required String nationalNumber,
    required String position,
    required String phone,
    required String address,
    required DateTime dateAccession,
  }) async {
    // التحقق من ملء كل الحقول
    // if (fullName.isEmpty ||
    //     email.isEmpty ||
    //     nationalNumber.isEmpty ||
    //     position.isEmpty ||
    //     phone.isEmpty ||
    //     address.isEmpty ||
    //     dateAccession.isEmpty) {
    //   _showError("يرجى ملء جميع الحقول قبل الحفظ");
    //   return;
    // }

    // if (!phone.startsWith("09") || phone.length != 10) {
    //   _showError("رقم الهاتف يجب أن يبدأ بـ 09 ويتكون من 10 أرقام");
    //   return;
    // }

    final updatedEmployee = Employee(
      // id: profile.id,
      fullName: fullName,
      email: email,
      nationalNumber: nationalNumber,
      position: position,
      phone: phone,
      address: address,
      // image: pickedImage.path ?? profile.image,
      dateAccession: profileAdminModel.data!.dateAccession,
      // team: profile.teamId,
      teamId: profileAdminModel.data!.teamId,
      specialization: profileAdminModel.data!.specializationId,
    );

    final success = await EmployeeService.updateEmployee(updatedEmployee);
    if (success) {
      profile = updatedEmployee;
      update();
      Get.snackbar(
        "نجاح",
        "تم تحديث المعلومات بنجاح",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(ButtomNavigationBarPage());
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
