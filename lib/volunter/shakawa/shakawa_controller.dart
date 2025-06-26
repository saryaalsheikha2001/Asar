import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:athar_project/volunter/tabroat/teams_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ComplaintController extends GetxController {
  // final teamNameController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  Future sendComplaint() async {
    try {
      if (descriptionController.text.isEmpty) {
        BotToast.showText(
          text: "خطأ\nيرجى تعبئة جميع الحقول",
          align: Alignment.center,
          contentColor: Colors.redAccent,
          textStyle: TextStyle(color: Colors.white),
        );
        // Get.snackbar(
        //   'خطأ',
        //   'يرجى تعبئة جميع الحقول',
        //   backgroundColor: Colors.redAccent,
        //   colorText: Colors.white,
        // );
      } else {
        // هون ممكن تبعت البيانات للسيرفر مثلاً

        Map<String, String> authHeaders = {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization':
              'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',

          //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
        };

        isLoadingSet(true);

        final http.Response response = await NetworkUtils.post(
          url: "requests",
          headers: authHeaders,
          body:
              selectedComplaintType == "suggestion"
                  ? json.encode({
                    "content": descriptionController.text,
                    "type": selectedComplaintType,
                  })
                  : json.encode({
                    "content": descriptionController.text,
                    "type": selectedComplaintType,
                    "team_id": "${selectedTeam!.id!}",
                  }),
        );
        log(response.body.toString(), name: "sendComplaint response body");
        if (response.statusCode == 200) {
          // var data = <dynamic>[];
          // data = json.decode(response.body);
          // messages.value = data.map((e) => MessageModel.fromJson(e)).toList();
          // return CompagineAdminModel.fromJson(data);
          BotToast.showText(
            text: "تم الإرسال\nتم إرسال الشكوى بنجاح ✅",
            align: Alignment.center,
            contentColor: Colors.green,
            textStyle: TextStyle(color: Colors.white),
          );
        }

        // بعدها نظف الحقول
        descriptionController.clear();

        // Get.snackbar(
        //   'تم الإرسال',
        //   'تم إرسال الشكوى بنجاح ✅',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      }
    } catch (e) {
    } finally {
      isLoadingSet(false);
    }
  }

  void selectTeam(TeamsData? team) {
    selectedTeam = team;
    update();
  }

  List<String> complaintType = ["complaints", "suggestion"];
  String selectedComplaintType = "complaints";

  TeamsData? selectedTeam;
  TeamsModel teamsModel = TeamsModel();
  Future<TeamsModel> getTeams() async {
    isLoadingSet(true);
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "get/all/volunteer/teams",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "getTeams response body");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        teamsModel = TeamsModel.fromJson(data);
        return TeamsModel.fromJson(data);
      }
      return TeamsModel();
    } catch (e) {
      log(e.toString(), name: "getTeams catch error");
      return TeamsModel();
    } finally {
      isLoadingSet(false);
    }
  }

  @override
  Future onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getTeams();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
