// import 'package:athar_project/admin/camplaints/Complaint_hmla_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ComplaintDetailsPage extends StatelessWidget {
//   const ComplaintDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Complaint_hmla_Model complaint = Get.arguments;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F2F5), 
//       appBar: AppBar(
//         backgroundColor: const Color(0xff003366),
//         centerTitle: true,
//         title: const Text(
//           'تفاصيل الشكوى',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildSectionTitle('اسم المتطوع'),

//                 // _buildContentText(complaint.volunteerName),
//                 const SizedBox(height: 20),

//                 _buildSectionTitle('اسم الحملة'),

//                 // _buildContentText(complaint.campaignName),
//                 const SizedBox(height: 20),

//                 _buildSectionTitle('تفاصيل الشكوى'),
//                 // _buildContentText(complaint.description),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         color: Color(0xff003366),
//         fontSize: 16,
//         fontWeight: FontWeight.w700,
//       ),
//     );
//   }

//   Widget _buildContentText(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 6),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 15,
//           color: Colors.black87,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
// }
