import 'package:athar_project/admin/Complaint_hmla_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintDetailsPage extends StatelessWidget {
  const ComplaintDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Complaint_hmla_Model complaint = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff003366),
        title: const Text(
          'تفاصيل الشكوى',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'اسم المتطوع: ${complaint.volunteerName}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 12),
              Text(
                'اسم الحملة: ${complaint.campaignName}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 12),
              Text(
                'التفاصيل:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(complaint.description, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
