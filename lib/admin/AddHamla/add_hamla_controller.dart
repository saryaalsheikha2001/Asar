import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/admin/homepage/home_page_controller.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CampaignController extends GetxController {
  final String apiToken = "38|R8xFJGuWpCH4DFCxykwbMBp0aRjFDBw9Er00mUrLf95409a0";

  Future<void> createCampaign({
    required String name,
    required String address,
    required String cost,
    required int volunteers,
    required String date,
    required String to,
    required int points,
    required String status,
    required String specializationId,
    required String campaignTypeId,
    required int teamId,
    required int employeeId,
    // required File image,
  }) async {
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };
      log("Start response", name: "Start response");
      final http.Response response = await NetworkUtils.post(
        url: "campaigns/create",
        headers: authHeaders,
        body: jsonEncode({
          "campaign_name": name,
          "number_of_volunteer": volunteers.toString(),
          "cost": cost,
          "address": address,
          "from": date,
          "to": date,
          "points": points.toString(),
          "specialization_id": specializationId,
          "campaign_type_id": campaignTypeId,
        }),
      );
      log(response.body.toString(), name: "createCampaign response body");
      log(
        jsonDecode(response.body)["message"],
        name: "createCampaign response body",
      );
      log(
        response.statusCode.toString(),
        name: "createCampaign response statuscode",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "تم",
          "✅ تم إنشاء الحملة بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
        Get.find<HomePageController>().getCampaignsPending();
      } else {
        Get.snackbar(
          "فشل",
          "❌ فشل في إنشاء الحملة\n${response.body}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log(e.toString(), name: "createCampaign catch error");
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء الاتصال بالسيرفر\n$e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
