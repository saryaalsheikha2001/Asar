import 'dart:convert';
import 'package:athar_project/volunter/shakawa/complaint_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllShakawaController extends GetxController {
  var isLoading = true;
  ComplaintModel complaints = ComplaintModel();

  @override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  void fetchComplaints() async {
    isLoading = true;
    update();

    final url = Uri.parse('http://volunteer.test-holooltech.com/api/requests');
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        complaints = ComplaintModel.fromJson(data);
      } else {
        Get.snackbar('فشل', 'لم يتم تحميل الشكاوى');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الاتصال');
    } finally {
      isLoading = false;
      update();
    }
  }
}
