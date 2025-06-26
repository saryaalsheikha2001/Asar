import 'dart:convert';
import 'dart:io';
import 'package:athar_project/admin/Attendance/attendance_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AttendanceController extends GetxController {
  List<AttendanceModel> attendances = [];
  bool isLoading = true;
  final picker = ImagePicker();

  // مفاتيح للبيانات المؤقتة
  Map<int, String> reasonOfChange = {};
  Map<int, File?> pickedImages = {};

  String token = "17|RWlT4AE2kWNfWUQEbo7Oq6ZElpFNjQnEHKzk9Rgxcdf6c9e9";

  @override
  void onInit() {
    fetchAttendances();
    super.onInit();
  }

  Future<void> fetchAttendances() async {
    isLoading = true;
    update();

    try {
      final response = await http.get(
        Uri.parse("http://volunteer.test-holooltech.com/api/attendances/campaign/3"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        attendances = (data['attendances'] as List)
            .map((e) => AttendanceModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar("خطأ", "فشل في جلب البيانات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر");
    }

    isLoading = false;
    update();
  }

  Future<void> pickImage(int volunteerId) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImages[volunteerId] = File(picked.path);
      update();
    }
  }

  Future<void> submitAttendance({
    required AttendanceModel item,
    required bool isPresent,
  }) async {
    final url = item.id != null
        ? "http://volunteer.test-holooltech.com/api/attendances/${item.id}"
        : "http://volunteer.test-holooltech.com/api/attendances";

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.headers['Authorization'] = 'Bearer $token';

    if (item.id != null) {
      request.fields['_method'] = 'PUT';
    }

    request.fields['volunteer_id'] = item.volunteerId.toString();
    request.fields['campaign_id'] = '3';
    request.fields['is_attendance'] = isPresent ? '1' : '0';
    request.fields['reason_of_change'] =
        reasonOfChange[item.volunteerId] ?? 'حضور';

    final imageFile = pickedImages[item.volunteerId];
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar("نجاح", "تم حفظ الحضور بنجاح");
      } else {
        Get.snackbar("خطأ", "فشل في إرسال الحضور");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الإرسال");
    }
  }
}
