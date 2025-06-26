// import 'package:athar_project/admin/Attendance/attendance_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AttendancePage extends StatelessWidget {
//   const AttendancePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AttendanceController>(
//       init: AttendanceController(),
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.blue[900],
//             title: const Text("أخذ الحضور", style: TextStyle(color: Colors.white)),
//           ),
//           body: controller.isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: controller.attendances.length,
//                   itemBuilder: (context, index) {
//                     final item = controller.attendances[index];
//                     return Card(
//                       margin: const EdgeInsets.all(8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.fullName,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 DropdownButton<String>(
//                                   value: controller.reasonOfChange[item.volunteerId],
//                                   hint: const Text("سبب التغيير"),
//                                   items: ['حضور', 'عدم حضور', 'عذر']
//                                       .map((reason) => DropdownMenuItem(
//                                             value: reason,
//                                             child: Text(reason),
//                                           ))
//                                       .toList(),
//                                   onChanged: (val) {
//                                     controller.reasonOfChange[item.volunteerId] = val!;
//                                     controller.update();
//                                   },
//                                 ),
//                                 const SizedBox(width: 16),
//                                 ElevatedButton.icon(
//                                   onPressed: () =>
//                                       controller.pickImage(item.volunteerId),
//                                   icon: const Icon(Icons.image),
//                                   label: const Text("صورة"),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () => controller.submitAttendance(
//                                       item: item, isPresent: true),
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.green),
//                                   child: const Text("حضور"),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 ElevatedButton(
//                                   onPressed: () => controller.submitAttendance(
//                                       item: item, isPresent: false),
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.red),
//                                   child: const Text("غياب"),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }
