import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:athar_project/volunter/tabroat/tabroat_model.dart';
import 'package:athar_project/volunter/tabroat/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TabroatController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TabroatModel tabroatModel = TabroatModel();

  TeamsData? selectedTeam;

  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController transferNumberTextEditingController =
      TextEditingController();

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  void selectTeam(TeamsData? team) {
    selectedTeam = team;
    update();
  }

  Future<TabroatModel> getTabroat() async {
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
        url: "donor-payments",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "getTabroat response body");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        tabroatModel = TabroatModel.fromJson(data);
        return TabroatModel.fromJson(data);
      }
      return TabroatModel();
    } catch (e) {
      log(e.toString(), name: "getTabroat catch error");
      return TabroatModel();
    } finally {
      isLoadingSet(false);
    }
  }

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

  Future<void> deleteTabroatById(int id) async {
    isLoadingSet(true);
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.delete(
        url: "donor-payments/$id",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "deleteTabroatById response body");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "تم الحذف",
          "تم حذف التبرع بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await getTabroat();
      }
    } catch (e) {
      log(e.toString(), name: "deleteTabroatById catch error");
    } finally {
      isLoadingSet(false);
    }
  }

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> postTabroat() async {
    if (!formKey.currentState!.validate()) return;

    isLoadingSet(true);

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };

    final uri = Uri.parse(
      'http://volunteer.test-holooltech.com/api/donor-payments',
    );
    final request = http.MultipartRequest("POST", uri);

    request.fields['team_id'] = selectedTeam!.id.toString();
    request.fields['amount'] = amountTextEditingController.text;
    request.fields['transfer_number'] =
        transferNumberTextEditingController.text;

    if (selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', selectedImage!.path),
      );
    }

    request.headers.addAll(authHeaders);

    try {
      final response = await request.send();

      log(response.statusCode.toString(), name: "response.statusCode");
      log(await response.stream.bytesToString(), name: "response.stream");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final resBody = await http.Response.fromStream(response);
        // final decoded = json.decode(resBody.body);

        // if (decoded['success'] == true) {
        Get.snackbar(
          "تم التحديث",
          "تم تعديل معلوماتك بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await getTabroat();
        Get.back(result: true);
        // } else {
        //   Get.snackbar(
        //     "فشل",
        //     decoded['message'] ?? 'فشل التحديث',
        //     backgroundColor: Colors.red,
        //     colorText: Colors.white,
        //   );
        // }
      } else {
        print(response);
        Get.snackbar(
          "خطأ",
          "فشل التعديل",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء التحديث: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingSet(false);
    }
  }

  @override
  Future onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getTabroat();
    await getTeams();
  }
}
