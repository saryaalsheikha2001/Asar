import 'package:athar_project/volunter/join_with_hamla/joined_with_hamla_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homepage/home_page_controller.dart';

class HamlaDetails extends StatelessWidget {
  final Hamla donation;

  const HamlaDetails({required this.donation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          donation.teamName ?? '',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(0, 51, 102, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
              ),
            ),
            SizedBox(height: 16),
            InfoTile(title: 'اسم الحملة', value: donation.teamName),
            InfoTile(title: 'مدير الحملة', value: donation.managerName),
            InfoTile(
              title: 'رقم التواصل مع المشرف',
              value: donation.phoneNumber,
            ),
            InfoTile(title: 'عدد الأعضاء', value: '${donation.membersCount}'),
            InfoTile(title: 'الموقع', value: 'دمشق'),
            InfoTile(title: 'المعدات اللازمة', value: donation.equipment),
            InfoTile(title: 'وقت الحملة', value: donation.time),
            InfoTile(title: 'رقم التواصل', value: donation.phoneNumber),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'وصف الحملة:\n${donation.description ?? ''}',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),

            // زر الانضمام
            ElevatedButton(
              onPressed: () async {
                final joinedCampaignController =
                    Get.find<JoinedCampaignController>();

                if (joinedCampaignController.joinedCampaigns.isNotEmpty) {
                  Get.snackbar(
                    'خطأ',
                    'أنت مشترك بحملة بالفعل، انتظر انتهاء الحملة الحالية.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                await joinedCampaignController.joinCampaign(donation);
                Get.snackbar(
                  'نجاح',
                  'تم الاشتراك في الحملة بنجاح!',
                  snackPosition: SnackPosition.TOP,
                );
                Get.snackbar(
                  'نجاح',
                  'تم الاشتراك في الحملة بنجاح!',
                  snackPosition: SnackPosition.TOP,
                );
                Get.back();
              },
              child: Text('اشترك بالحملة'),
            ),

            SizedBox(height: 16),

            // زر المحادثة (غير مفعل)
            ElevatedButton.icon(
              onPressed: () {
                // ممكن مستقبلا تفعّل المحادثة هنا
              },
              icon: Icon(Icons.chat),
              label: Text('محادثة', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String? value;

  const InfoTile({required this.title, required this.value, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 95,
      child: Center(
        child: Text('$title: ${value ?? ''}', textAlign: TextAlign.right),
      ),
    );
  }
}
