import 'dart:convert';
import 'dart:developer';
import 'package:athar_project/admin/core/model/login_admin_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String baseUrl = "http://volunteer.test-holooltech.com/api";
  static const String token =
      "10|UguwhnnFkBwQCVEPY56ZsHsXEPHGQH2a8GyeMOr66b51e2aa";

  static Future<bool> updateEmployee(Employee employee) async {
    final url = Uri.parse("$baseUrl/employee/update");

    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      },
      body: jsonEncode(employee.toJson()),
    );

    log(response.statusCode.toString(), name: "response.statusCode");
    log(response.body.toString(), name: "response.body");

    return response.statusCode == 200;
  }
}
