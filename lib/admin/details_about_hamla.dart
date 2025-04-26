import 'package:athar_project/admin/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampaignDetailsPage extends StatelessWidget {
  final Map<String, String> campaign;

  const CampaignDetailsPage({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            campaign['name'] ?? 'تفاصيل الحملة',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Get.back();
            },
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    campaign['image']!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),

                // تفاصيل الحملة داخل بطاقات أنيقة
                _buildInfoCard(
                  icon: Icons.category,
                  label: 'نوع الحملة',
                  value: campaign['type']!,
                ),
                _buildInfoCard(
                  icon: Icons.people,
                  label: 'عدد المشاركين',
                  value: campaign['participants']!,
                ),
                _buildInfoCard(
                  icon: Icons.attach_money,
                  label: 'المبلغ',
                  value: campaign['amount']!,
                ),
                _buildInfoCard(
                  icon: Icons.calendar_today,
                  label: 'التاريخ',
                  value: campaign['date']!,
                ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // زر تنفيذ - يمكن توجيهه لتعديل أو مشاركة الحملة
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      'تعديل الحملة',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // إنهاء الحملة
                      Get.find<HomePageController>().finishCampaign(campaign);
                      Get.back(); // العودة إلى الصفحة الرئيسية بعد التحديث
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text(
                      'إنهاء الحملة',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: const Color.fromRGBO(0, 51, 102, 1)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
