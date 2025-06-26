import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/admin/Attendance/attendance_by_campaign_model.dart';
// import 'package:athar_project/admin/Attendance/attendance_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:athar_project/admin/model/CompagineAdmin_model.dart' as gg;

class AttendanceControllerForDoneCampaigns extends GetxController {
  AttendanceByCampaignModel attendances = AttendanceByCampaignModel();
  bool isLoading = true;
  final picker = ImagePicker();

  // مفاتيح للبيانات المؤقتة
  Map<int, String> reasonOfChange = {};
  Map<int, File?> pickedImages = {};

  // String selectedReason = "حضور";

  List<String> reasonsList = ['حضور', 'عدم حضور', 'عذر'];

  final int id;
  final List<gg.Volunteer> volunteerList;
  AttendanceControllerForDoneCampaigns(this.id, this.volunteerList);

  @override
  void onInit() {
    fetchAttendances();
    super.onInit();
  }

  Future<void> fetchAttendances() async {
    isLoading = true;
    update();
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };
    try {
      final response = await http.get(
        Uri.parse(
          "http://volunteer.test-holooltech.com/api/attendances/campaign/$id",
        ),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        log(
          response.statusCode.toString(),
          name: "fetchAttendances response.statusCode",
        );
        log(response.body.toString(), name: "fetchAttendances response.body");
        final data = json.decode(response.body);
        attendances = AttendanceByCampaignModel.fromJson(data);
      } else {
        Get.snackbar("خطأ", "فشل في جلب البيانات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر");
    }

    isLoading = false;
    update();
  }
}
