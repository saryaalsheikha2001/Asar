import 'package:athar_project/volunter/shakawa/shakawa_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsPage extends StatelessWidget {
  ComplaintsPage({super.key});

  final ComplaintController controller = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3C6E),
        centerTitle: true,
        title: const Text(
          'الشكاوي',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اسم الفريق',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.teamNameController,
                decoration: InputDecoration(
                  hintText: 'اسم الفريق',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'شكوى/اقتراح',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.complaintTypeController,
                decoration: InputDecoration(
                  hintText: 'نوع العملية',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'شرح عن العملية',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.sendComplaint();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A3C6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ارسل',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
