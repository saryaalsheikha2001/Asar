import 'package:athar_project/admin/UpdateHamla/update_hamla.dart';
import 'package:athar_project/admin/model/CompagineAdmin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homepage/home_page_controller.dart';

class CampaignDetailsPage extends StatelessWidget {
  final Datum campaign;

  const CampaignDetailsPage({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            campaign.campaignName ?? 'تفاصيل الحملة',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.back(),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (campaign.team?.logo != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'http://volunteer.test-holooltech.com/${campaign.team!.logo!}',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 24),
              _buildInfoCard(
                icon: Icons.category,
                label: 'نوع الحملة',
                value: campaign.campaignType?.name.toString() ?? 'غير محدد',
              ),
              _buildInfoCard(
                icon: Icons.people,
                label: 'عدد المتطوعين',
                value: campaign.numberOfVolunteer?.toString() ?? 'غير معروف',
              ),
              _buildInfoCard(
                icon: Icons.attach_money,
                label: 'المبلغ',
                value: '${campaign.cost ?? '0'} \$',
              ),
              _buildInfoCard(
                icon: Icons.calendar_today,
                label: 'التاريخ',
                value: campaign.from.toString() ?? '',
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Get.toNamed("");
                    Get.to(() => UpdateHamlaPage(campaign));
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
                    Get.find<HomePageController>().finishCampaign(
                      campaign as Map<String, String>,
                    );
                    Get.back();
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
