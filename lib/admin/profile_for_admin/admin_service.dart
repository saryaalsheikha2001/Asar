import 'dart:convert';
import 'package:athar_project/admin/core/model/login_admin_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String baseUrl = "http://volunteer.test-holooltech.com/api";
  static const String token = "10|UguwhnnFkBwQCVEPY56ZsHsXEPHGQH2a8GyeMOr66b51e2aa";

  static Future<bool> updateEmployee(Employee employee) async {
    final url = Uri.parse("$baseUrl/employee/update");

    final response = await http.put(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(employee.toJson()),
    );

    return response.statusCode == 200;
  }
}
