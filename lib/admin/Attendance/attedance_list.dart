import 'package:athar_project/admin/Attendance/Attendance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'attendance_model.dart';
import 'attendance_controller.dart';

class AttendancesListPage extends StatelessWidget {
  final AttendanceController controller;
  const AttendancesListPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.attendances.isEmpty) {
        return const Center(child: Text("لا توجد سجلات حضور."));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: controller.attendances.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = controller.attendances[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person, color: Colors.black54),
              ),
              title: Text(
                item.volunteerName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item.isAttendance ? "حضر ✅" : "لم يحضر ❌",
                style: TextStyle(
                  color: item.isAttendance ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                "+${item.pointsEarned} نقطة",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C63FF),
                ),
              ),
              onTap: () {
                Get.to(() => AttendanceDetailsPage(attendance: item));
              },
            ),
          );
        },
      );
    });
  }
}
