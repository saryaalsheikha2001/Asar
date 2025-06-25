import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/core/model/login_volunteer_model.dart';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:athar_project/volunter/homepage/home_page_controller.dart';
import 'package:athar_project/volunter/join_with_hamla/joined_with_hamla_controller.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class login_volunter_controller extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordHidden = true;

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  Future<dynamic> login() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoadingSet(true);
        var storage = Get.find<StorageService>();
        final http.Response response = await NetworkUtils.post(
          url: "volunteer/login",
          headers: NetworkUtils.headers,
          body: json.encode({
            "email": emailController.text,
            "password": passwordController.text,
          }),
        );
        log(response.body.toString(), name: "login response body");
        if (response.statusCode == 201 || response.statusCode == 200) {
          Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح");
          storage.storeVolunteerTokenInfo(
            LoginVolunteerModel.fromJson(json.decode(response.body)),
          );
          storage.setLoginAccountType(false);
          Get.put(HamlaController()).onInit();
          Get.put(JoinedCampaignController()).onInit();
          Get.put(DetailVoulnterController()).onInit();
          Get.offAllNamed('/homepage_voulnter');
        } else {
          Get.snackbar(
            "فشل",
            "بيانات الدخول غير صحيحة",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        log(e.toString(), name: "login catch error");
      } finally {
        isLoadingSet(false);
      }
      // Get.off(
      //   () => detail_voulnter(),
      //   arguments: {'name': nameController.text, 'email': emailController.text},
      // );
    }
  }

  // void login() {
  //   if (formKey.currentState!.validate()) {
  //     final email = emailController.text;
  //     final password = passwordController.text;

  //     // منطق تحقق مزيف (مكان التحقق من قاعدة بيانات أو API)
  //     if (email == "volunteer@test.com" && password == "12345678") {
  //       Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح");
  //       // Get.offAllNamed('/homepage_voulnter');
  //       Get.offAllNamed('/buttom_navigation_bar_voulnter');
  //     } else {
  //       Get.snackbar(
  //         "فشل",
  //         "بيانات الدخول غير صحيحة",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     }
  //   }
  // }
}
