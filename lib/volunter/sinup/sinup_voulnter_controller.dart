import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/core/model/login_volunteer_model.dart';
import 'package:athar_project/volunter/core/model/specializations_model.dart';
import 'package:athar_project/volunter/details_about_voulnter/details_voulnter.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class sinup_voulnter_controller extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true;

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  List<SpecializationsModel> specializations = [];
  SpecializationsModel? selectedSpecialization;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  Future<List<SpecializationsModel>> getSpecializations() async {
    try {
      final http.Response response = await NetworkUtils.get(
        url: "specializations",
        headers: NetworkUtils.headers,
      );
      log(response.body.toString(), name: "getSpecializations response body");
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => SpecializationsModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      log(e.toString(), name: "getSpecializations catch error");
      return [];
    } finally {}
  }

  Future<dynamic> register() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoadingSet(true);
        var storage = Get.find<StorageService>();
        final http.Response response = await NetworkUtils.post(
          url: "volunteer/register",
          headers: NetworkUtils.headers,
          body: {
            "full_name": nameController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "specialization_id": selectedSpecialization!.id.toString(),
          },
        );

        log(response.body.toString(), name: "register response body");

        if (response.statusCode == 201 || response.statusCode == 200) {
          Get.snackbar("نجاح", "تم التسجيل بنجاح");
          storage.storeVolunteerTokenInfo(
            LoginVolunteerModel.fromJson(json.decode(response.body)),
          );
          storage.setLoginAccountType(false);
          Get.offAllNamed('/homepage_voulnter');
        } else {
          Get.snackbar(
            "فشل",
            json.decode(response.body)["message"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        log(e.toString(), name: "register catch error");
      } finally {
        isLoadingSet(false);
      }
      // Get.off(
      //   () => detail_voulnter(),
      //   arguments: {'name': nameController.text, 'email': emailController.text},
      // );
    }
  }

  @override
  Future onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLoadingSet(true);
    specializations = await getSpecializations();
    isLoadingSet(false);
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
