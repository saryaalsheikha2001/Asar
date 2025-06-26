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

class AttendanceController extends GetxController {
  AttendanceByCampaignModel attendances = AttendanceByCampaignModel();
  bool isLoading = true;
  final picker = ImagePicker();

  List<Attendancev2Model> attendancev2Model = [];

  // مفاتيح للبيانات المؤقتة
  Map<int, String> reasonOfChange = {};
  Map<int, File?> pickedImages = {};

  // String selectedReason = "حضور";

  List<String> reasonsList = ['حضور', 'عدم حضور', 'عذر'];

  final int id;
  final List<gg.Volunteer> volunteerList;
  AttendanceController(this.id, this.volunteerList);

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
        for (var element in attendances.attendances!) {
          attendancev2Model.add(
            Attendancev2Model(
              attendaceId: element.id,
              volunteerId: element.volunteerId,
              volunteerName: element.volunteer?.fullName ?? "",
              campaignId: element.campaignId,
              isAttendance: element.isAttendance,
              reasonOfChange: element.isAttendance == 1 ? "حضور" : "عدم حضور",
              imagePath: element.image,
            ),
          );
          if (element.image != null) {
            pickedImages[element.volunteerId!] = File(element.image ?? "");
          }
          if (element.isAttendance != null) {
            reasonOfChange[element.volunteerId!] =
                (element.isAttendance == 1 ? "حضور" : "عدم حضور");
          }
        }
        for (var element in volunteerList) {
          if (!attendancev2Model.any(
            (element2) => element2.volunteerId == element.id,
          )) {
            attendancev2Model.add(
              Attendancev2Model(
                attendaceId: null,
                volunteerId: element.id,
                volunteerName: element.fullName ?? "",
                campaignId: id,
                isAttendance: null,
                reasonOfChange: null,
                imagePath: null,
              ),
            );
          }
        }
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
    // required AttendanceModel item,
    required int volunteerId,
    required int campaignId,
    int? attendanceId,
  }) async {
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };
    final url =
        attendanceId != null
            ? "http://volunteer.test-holooltech.com/api/attendances/$attendanceId"
            : "http://volunteer.test-holooltech.com/api/attendances";

    // final url = "http://volunteer.test-holooltech.com/api/attendances";

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(authHeaders);
    final imageFile = pickedImages[volunteerId];

    if (attendanceId != null) {
      request.fields['_method'] = 'PUT';
      request.fields['is_attendance'] =
          (reasonOfChange[volunteerId] ?? "حضور") == "حضور" ? '1' : '0';
      request.fields['reason_of_change'] =
          reasonOfChange[volunteerId] ?? "حضور";
      if (imageFile != null && !imageFile.path.contains("attendances")) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }
    } else {
      request.fields['volunteer_id'] = volunteerId.toString();
      request.fields['campaign_id'] = campaignId.toString();
      request.fields['is_attendance'] =
          (reasonOfChange[volunteerId] ?? "حضور") == "حضور" ? '1' : '0';
      request.fields['reason_of_change'] =
          reasonOfChange[volunteerId] ?? "حضور";

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }
    }

    try {
      final response = await request.send();
      log(
        response.statusCode.toString(),
        name: "submitAttendance response.statusCode",
      );
      log(
        await response.stream.bytesToString(),
        name: "submitAttendance response.stream",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("نجاح", "تم حفظ الحضور بنجاح");
      } else {
        Get.snackbar("خطأ", "فشل في إرسال الحضور");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الإرسال");
    }
  }
}

class Attendancev2Model {
  int? attendaceId;
  int? volunteerId;
  String? volunteerName;
  int? campaignId;
  int? isAttendance;
  String? reasonOfChange;
  String? imagePath;

  Attendancev2Model({
    this.attendaceId,
    this.volunteerId,
    this.volunteerName,
    this.campaignId,
    this.isAttendance,
    this.reasonOfChange,
    this.imagePath,
  });

  factory Attendancev2Model.fromJson(Map<String, dynamic> json) =>
      Attendancev2Model(
        attendaceId: json["attendaceId"],
        volunteerId: json["volunteer_id"],
        volunteerName: json["volunteer_name"],
        campaignId: json["campaign_id"],
        isAttendance: json["is_attendance"],
        reasonOfChange: json["reason_of_change"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
    "attendaceId": attendaceId,
    "volunteer_id": volunteerId,
    "volunteer_name": volunteerName,
    "campaign_id": campaignId,
    "is_attendance": isAttendance,
    "reason_of_change": reasonOfChange,
    "image_path": imagePath,
  };
}
