import 'package:get/get.dart';

class HomePageController extends GetxController {
  var searchQuery = ''.obs;
  int currentIndex = 1;

  final campaigns =
      List.generate(
        9,
        (index) => {
          'name': 'اسم الحملة $index',
          'type': 'نوع الحملة',
          'date': '18/5/2020',
          'amount': '200\$',
          'participants': '${index + 10} مشارك',
          'image':
              'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
        },
      ).obs;

  // قائمة الحملات المنتهية
  var finishedCampaigns = <Map<String, String>>[].obs;

  // تصفية الحملات بناءً على البحث
  List<Map<String, String>> get filteredCampaigns {
    if (searchQuery.value.isEmpty) return campaigns;
    return campaigns
        .where(
          (campaign) =>
              campaign['name']!.contains(searchQuery.value) ||
              campaign['type']!.contains(searchQuery.value),
        )
        .toList();
  }

  void finishCampaign(Map<String, String> campaign) {
    campaigns.remove(campaign);
    finishedCampaigns.add(campaign);
    update();
  }

  void addCampaign(Map<String, String> newCampaign) {
    campaigns.add(newCampaign);
    update();
  }
}
