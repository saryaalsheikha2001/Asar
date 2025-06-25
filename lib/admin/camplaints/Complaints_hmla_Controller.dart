import 'dart:convert';
import 'dart:developer';
import 'package:athar_project/admin/camplaints/complaint_hmla_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

class ComplaintsController extends GetxController {
  RxList<Datum> complaints = <Datum>[].obs;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchComplaints();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> fetchComplaints() async {
    setLoading(true);
    try {
      final response = await NetworkUtils.get(
        url: "get-requests-team",
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization':
              'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
        },
      );

      log(response.body.toString(), name: "get complaints response body");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = complaintHmlaModelFromJson(response.body);
        complaints.assignAll(data.data ?? []);
      } else {
        log('Failed to load complaints');
      }
    } catch (e) {
      log('Error fetching complaints: \$e');
    } finally {
      setLoading(false);
    }
  }

  void deleteComplaint(int id) {
    complaints.removeWhere((item) => item.id == id);
  }

  void deleteAll() {
    complaints.clear();
  }

  void goToComplaintDetails(Datum complaint) {
    Get.toNamed('/complaint-details', arguments: complaint);
  }
}
