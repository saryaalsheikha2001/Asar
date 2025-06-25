import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'attendance_model.dart';

class AttendanceDetailsPage extends StatelessWidget {
  final AttendanceModel attendance;

  const AttendanceDetailsPage({super.key, required this.attendance});

  String imageUrl(String? path) {
    return path != null
        ? 'http://volunteer.test-holooltech.com/storage/$path'
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الحضور"),
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Volunteer Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      attendance.volunteerImage != null
                          ? NetworkImage(imageUrl(attendance.volunteerImage!))
                          : null,
                  child:
                      attendance.volunteerImage == null
                          ? const Icon(Icons.person, size: 28)
                          : null,
                ),
                title: Text(
                  attendance.volunteerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text("Total Points: ${attendance.totalPoints}"),
              ),
            ),

            const SizedBox(height: 16),

            /// Employee Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      attendance.employeeImage != null
                          ? NetworkImage(imageUrl(attendance.employeeImage!))
                          : null,
                  child:
                      attendance.employeeImage == null
                          ? const Icon(Icons.person_pin, size: 28)
                          : null,
                ),
                title: Text(
                  attendance.employeeName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text("Supervisor"),
              ),
            ),

            const SizedBox(height: 16),

            /// Status
            Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  attendance.isAttendance ? "Present ✅" : "Absent ❌",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Attendance Image
            if (attendance.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl(attendance.image!),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),

            /// Date Info
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  "Attendance Date: ${DateFormat('MMM d, y').format(attendance.createdAt)}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
