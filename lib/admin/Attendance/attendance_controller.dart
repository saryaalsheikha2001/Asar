import 'dart:convert';
import 'dart:developer';
import 'package:athar_project/admin/Attendance/attendance_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  var attendances = <AttendanceModel>[].obs;
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  // ✅ جلب الحضور من السيرفر
  Future<void> fetchAttendances() async {
    try {
      setLoading(true);

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      };

      final response = await NetworkUtils.get(
        url: 'attendances',
        headers: headers,
      );

      log(response.body.toString(), name: '📥 Attendance API Response');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // ✅ دعم الصيغتين (List مباشرة أو ضمن attendances)
        if (jsonData is List) {
          attendances.value = jsonData.map((e) => AttendanceModel.fromJson(e)).toList();
        } else if (jsonData is Map<String, dynamic> && jsonData['attendances'] != null) {
          attendances.value = (jsonData['attendances'] as List)
              .map((e) => AttendanceModel.fromJson(e))
              .toList();
        } else {
          attendances.value = [];
        }
      } else {
        log('⚠️ فشل في جلب البيانات - Status: ${response.statusCode}', name: 'Attendance Error');
        attendances.value = [];
      }
    } catch (e) {
      log('❌ Exception أثناء جلب الحضور: $e', name: 'Attendance Exception');
      attendances.value = [];
    } finally {
      setLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAttendances();
  }
}
