import 'package:athar_project/volunter/shakawa/all_shakawa_page.dart';
import 'package:athar_project/volunter/shakawa/shakawa_controller.dart';
import 'package:athar_project/volunter/tabroat/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsPage extends StatelessWidget {
  ComplaintsPage({super.key});

  // final ComplaintController controller = Get.find<ComplaintController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintController>(
      init: ComplaintController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6FAFF),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => AllShakawaPage());
                },
                icon: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text(
                      "جميع الشكاوي ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            backgroundColor: const Color(0xFF0A3C6E),
            centerTitle: true,
            title: const Text(
              'الشكاوي',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            elevation: 0,
            automaticallyImplyLeading: true,
          ),
          body:
              controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
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
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<TeamsData>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: "اختر الفريق",
                              border: OutlineInputBorder(),
                            ),
                            value: controller.selectedTeam,
                            items:
                                controller.teamsModel.data!.map((team) {
                                  return DropdownMenuItem<TeamsData>(
                                    value: team,
                                    child: Text(team.teamName ?? ""),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              controller.selectTeam(value);
                            },
                          ),
                          const SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'شكوى/اقتراح',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: "شكوى/اقتراح",
                              border: OutlineInputBorder(),
                            ),
                            value: controller.selectedComplaintType,
                            items:
                                controller.complaintType.map((team) {
                                  return DropdownMenuItem<String>(
                                    value: team,
                                    child: Text(team),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              controller.selectedComplaintType = value!;
                            },
                          ),
                          // TextFormField(
                          //   controller: controller.complaintTypeController,
                          //   decoration: InputDecoration(
                          //     hintText: 'نوع العملية',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 16,
                          //       vertical: 12,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'شرح عن العملية',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
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
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        );
      },
    );
  }
}
