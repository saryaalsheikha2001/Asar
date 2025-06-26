import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/admin/homepage/home_page_controller.dart';
import 'package:athar_project/admin/model/CompagineAdmin_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class UpdateCampaignController extends GetxController {
  final String apiToken = "38|R8xFJGuWpCH4DFCxykwbMBp0aRjFDBw9Er00mUrLf95409a0";

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final costController = TextEditingController();
  final volunteersController = TextEditingController();
  final dateController = TextEditingController();
  final toController = TextEditingController();
  final pointsController = TextEditingController();

  bool isLoading = false;

  DateTime? selectedDateTime;
  Datum campaign;

  UpdateCampaignController(this.campaign);

  Future<void> pickDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    // Step 1: Pick Date
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return; // Cancelled

    // Step 2: Pick Time
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime:
          selectedDateTime != null
              ? TimeOfDay.fromDateTime(selectedDateTime!)
              : TimeOfDay.now(),
    );

    if (time == null) return; // Cancelled

    // Combine date & time
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    selectedDateTime = dateTime;

    controller.text = DateFormat(
      'yyyy-MM-dd hh:mm:ss',
    ).format(selectedDateTime!);
    update();
  }

  Future<void> pickBirthDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 18),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  Future submitForm() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();
      // String name = nameController.text.trim();
      // String address = locationController.text.trim();
      // String cost = costController.text.trim();
      // int volunteers = int.tryParse(volunteersController.text.trim()) ?? 0;
      // String date = dateController.text.trim();
      // String to = dateController.text.trim();
      // int points = int.tryParse(pointsController.text.trim()) ?? 0;

      // String status = "active";
      // String specializationId = "1";
      // String campaignTypeId = "1";
      // int teamId = 1;
      // int employeeId = 1;

      await updateCampaign(
        id: campaign.id.toString(),
        name: nameController.text.trim(),
        address: locationController.text.trim(),
        cost: costController.text.trim(),
        volunteers: int.tryParse(volunteersController.text.trim()) ?? 0,
        date: dateController.text.trim(),
        to: dateController.text.trim(),
        points: int.tryParse(pointsController.text.trim()) ?? 0,
        status: "active",
        specializationId: campaign.specialization!.id.toString(),
        // Get.find<StorageService>()
        //     .getEmployeeTokenInfo()
        //     .employee!
        //     .specializationId
        //     .toString(),
        campaignTypeId: campaign.campaignType!.id.toString(),
        teamId: campaign.team!.id!,
        employeeId:
            Get.find<StorageService>().getEmployeeTokenInfo().employee!.id!,
        // image: _image!,
      );

      isLoading = false;
      update();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('يرجى تعبئة جميع الحقول واختيار صورة'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> updateCampaign({
    required String id,
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
      final http.Response response = await NetworkUtils.put(
        url: "campaigns/$id",
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
      log(response.body.toString(), name: "updateCampaign response body");
      log(
        jsonDecode(response.body)["message"],
        name: "updateCampaign response body",
      );
      log(
        response.statusCode.toString(),
        name: "updateCampaign response statuscode",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "تم",
          "✅ تم إنشاء الحملة بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
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
      log(e.toString(), name: "updateCampaign catch error");
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء الاتصال بالسيرفر\n$e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      Get.find<HomePageController>().getCampaignsPending();
    }
  }

  @override
  Future onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    update();

    nameController.text = campaign.campaignName!;
    locationController.text = campaign.address!;
    costController.text = campaign.cost!;
    volunteersController.text = campaign.numberOfVolunteer.toString();
    dateController.text = DateFormat(
      'yyyy-MM-dd hh:mm:ss',
    ).format(campaign.from!);
    toController.text = DateFormat(
      'yyyy-MM-dd hh:mm:ss',
    ).format(campaign.from!);
    pointsController.text = campaign.points.toString();
    // status:
    // "active";
    // specializationId:
    // "1";
    // campaignTypeId:
    // "1";
    // teamId:
    // 1;
    // employeeId:
    // 1;
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    update();
  }
}
