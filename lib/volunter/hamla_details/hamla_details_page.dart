// hamla_details.dart
import 'dart:developer';

import 'package:athar_project/volunter/chat_voulnter/chat_rom_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:athar_project/volunter/hamla_details/hamla_details_controller.dart';
import 'package:athar_project/volunter/join_with_hamla/joined_with_hamla_controller.dart';
import 'package:athar_project/volunter/chat_voulnter/chat_room_page.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import '../homepage/home_page_controller.dart';

class HamlaDetails extends StatelessWidget {
  final int id;
  final bool showChatButton;

  const HamlaDetails({required this.id, this.showChatButton = false, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HamlaDetailsController>(
      init: HamlaDetailsController(id),
      builder: (controller) {
        return controller.isLoading
            ? const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            )
            : Scaffold(
              appBar: AppBar(
                title: Text(
                  controller.campaignDetailsModel.data?.team?.teamName ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color(0xFF003366),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF003366),
                          width: 3,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "http://volunteer.test-holooltech.com/" +
                                (controller
                                        .campaignDetailsModel
                                        .data
                                        ?.team
                                        ?.logo ??
                                    ''),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildInfoCard(
                      'اسم الحملة',
                      controller.campaignDetailsModel.data?.team?.teamName,
                    ),
                    buildInfoCard(
                      'مدير الحملة',
                      controller.campaignDetailsModel.data?.employee?.fullName,
                    ),
                    buildInfoCard(
                      'رقم المشرف',
                      controller.campaignDetailsModel.data?.employee?.phone,
                    ),
                    buildInfoCard(
                      'الموقع',
                      controller.campaignDetailsModel.data?.address,
                    ),
                    buildInfoCard(
                      'وقت الحملة',
                      controller.campaignDetailsModel.data?.from
                          ?.toIso8601String(),
                    ),
                    buildInfoCard(
                      'رقم التواصل',
                      controller.campaignDetailsModel.data?.team?.phone,
                    ),
                    const SizedBox(height: 30),
                    // زر الاشتراك
                    if (!showChatButton)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final joinedController = Get.put(
                              JoinedCampaignController(),
                            );
                            final data = controller.campaignDetailsModel.data;
                            // if (data == null || data.team == null) {
                            //   Get.snackbar(
                            //     'خطأ',
                            //     'بيانات الحملة غير مكتملة.',
                            //     backgroundColor: Colors.red.shade100,
                            //   );
                            //   return;
                            // }
                            // if (joinedController.joinedCampaigns.isNotEmpty) {
                            //   Get.snackbar(
                            //     'خطأ',
                            //     'أنت مشترك بحملة بالفعل.',
                            //     backgroundColor: Colors.red.shade100,
                            //   );
                            //   return;
                            // }
                            if (joinedController.joinedCampaigns.isEmpty) {
                              joinedController.joinCampaign(data!);
                              Get.snackbar(
                                'تم الاشتراك',
                                'تم الاشتراك بالحملة بنجاح!',
                                backgroundColor: Colors.green.shade100,
                              );
                            } else {
                              Get.snackbar(
                                'خطأ',
                                'أنت مشترك بحملة بالفعل.',
                                backgroundColor: Colors.red.shade100,
                              );
                            }

                            // try {
                            //   final token =
                            //       Get.find<StorageService>()
                            //           .getVolunteerTokenInfo()
                            //           .token ??
                            //       '';
                            //   final url =
                            //       'http://volunteer.test-holooltech.com/api/campaigns/${data.id}/volunteers';
                            //   final response = await http.post(
                            //     Uri.parse(url),
                            //     headers: {
                            //       'Accept': 'application/json',
                            //       'Content-Type': 'application/json',
                            //       'Authorization': 'Bearer $token',
                            //     },
                            //   );

                            //   log(
                            //     response.statusCode.toString(),
                            //     name: "response.statusCode",
                            //   );
                            //   log(
                            //     response.body.toString(),
                            //     name: "response.body",
                            //   );

                            //   if (response.statusCode == 200) {
                            //     final hamla = Hamla(
                            //       id: data.id ?? 0,
                            //       teamName: data.team?.teamName ?? '',
                            //       image:
                            //           "http://volunteer.test-holooltech.com/${data.team?.logo ?? ''}",
                            //       time: data.from?.toIso8601String() ?? '',
                            //     );
                            //     await joinedController.joinCampaign(hamla);
                            //     Get.snackbar(
                            //       'تم الاشتراك',
                            //       'تم الاشتراك بالحملة بنجاح!',
                            //       backgroundColor: Colors.green.shade100,
                            //     );
                            //     Get.back();
                            //   } else {
                            //     Get.snackbar(
                            //       'خطأ',
                            //       'فشل الاشتراك بالحملة.',
                            //       backgroundColor: Colors.red.shade100,
                            //     );
                            //   }
                            // } catch (e) {
                            //   Get.snackbar(
                            //     'خطأ',
                            //     'حدث خطأ أثناء الاتصال بالسيرفر.',
                            //     backgroundColor: Colors.red.shade100,
                            //   );
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003366),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'اشترك بالحملة',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    // زر المحادثة
                    if (showChatButton)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // اذهب إلى صفحة المحادثة مع اسم الحملة
                            final chatName =
                                controller
                                    .campaignDetailsModel
                                    .data
                                    ?.team
                                    ?.teamName ??
                                'محادثة';
                            Get.to(
                              () => ChatRoomsPage(
                                // chatName: chatName,
                                // roomId:
                                //     controller.campaignDetailsModel.data!.id!,
                                // chatRoomId:
                                //     controller.campaignDetailsModel.data!.id!,
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat, color: Colors.white),
                          label: const Text(
                            "المحادثة",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF003366),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
      },
    );
  }

  Widget buildInfoCard(String title, String? value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF003366),
            fontSize: 16,
          ),
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          value ?? '',
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
