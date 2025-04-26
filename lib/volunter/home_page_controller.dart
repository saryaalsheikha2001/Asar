import 'package:get/get.dart';

class Hamla {
  final String teamName;
  final String image;
  final String managerName;
  final int membersCount;
  final String equipment;
  final String time;

  Hamla({
    required this.teamName,
    required this.image,
    required this.managerName,
    required this.membersCount,
    required this.equipment,
    required this.time,
  });
}

class HamlaController extends GetxController {
  var donations = <Hamla>[].obs;
  var filteredDonations = <Hamla>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDonations();
  }

  void loadDonations() {
    donations.value = List.generate(
      5,
      (index) => Hamla(
        teamName: 'فريق ${index + 1}',
        image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
        managerName: 'أحمد العلي',
        membersCount: 10 + index,
        equipment: 'معدات تنظيف، قفازات، أكياس',
        time: 'السبت الساعة ${9 + index} صباحًا',
      ),
    );
    filteredDonations.value = donations;
  }

  void searchByTeamName(String query) {
    if (query.isEmpty) {
      filteredDonations.value = donations;
    } else {
      filteredDonations.value = donations
          .where((d) => d.teamName.contains(query))
          .toList();
    }
  }
}
