import 'package:get/get.dart';
import 'notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = true.obs;

  final String apiUrl =
      'http://volunteer.test-holooltech.com/api/notifications';
  final String token;

  NotificationController(this.token);

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final List items = jsonData['notifications'];
        notifications.value =
            items.map((item) => NotificationModel.fromJson(item)).toList();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
