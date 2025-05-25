import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/core/model/campaigns_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Hamla {
  final String? teamName;
  final String? image;
  final String? managerName;
  final int? membersCount;
  final String? equipment;
  final String? time;
  final String? description; // <-- جديد
  final String? phoneNumber; // <-- جديد

  Hamla({
    this.teamName,
    this.image,
    this.managerName,
    this.membersCount,
    this.equipment,
    this.time,
    this.description, // <-- جديد
    this.phoneNumber, // <-- جديد
  });
}

class HamlaController extends GetxController {
  // var donations = <Hamla>[].obs;
  // var filteredDonations = <Hamla>[].obs;

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  CampaignsModel campaignsModel = CampaignsModel();

  Future<CampaignsModel> getCampaigns() async {
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "campaigns",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "getCampaigns response body");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return CampaignsModel.fromJson(data);
      }
      return CampaignsModel();
    } catch (e) {
      log(e.toString(), name: "getCampaigns catch error");
      return CampaignsModel();
    } finally {}
  }

  @override
  Future onInit() async {
    super.onInit();
    isLoadingSet(true);
    campaignsModel = await getCampaigns();
    isLoadingSet(false);
    // loadDonations();
  }

  // void loadDonations() {
  //   donations.value = [
  //     Hamla(
  //       teamName: 'حملة تنظيف مشفى المجتهد',
  //       image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
  //       managerName: 'أحمد العلي',
  //       membersCount: 12,
  //       equipment: 'معدات تنظيف، قفازات، كمامات',
  //       time: 'السبت الساعة 9 صباحًا',
  //       description: 'تنظيف مشفى المجتهد لتعقيم الصالات والغرف.',
  //       phoneNumber: '0934123456',
  //     ),
  //     Hamla(
  //       teamName: 'حملة تشجير شارع الميدان',
  //       image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
  //       managerName: 'ليلى عبد الرحمن',
  //       membersCount: 20,
  //       equipment: 'أدوات زراعة، شتول، أسمدة',
  //       time: 'الأحد الساعة 10 صباحًا',
  //       description: 'تشجير الأرصفة في شارع الميدان.',
  //       phoneNumber: '0934987654',
  //     ),
  //     Hamla(
  //       teamName: 'حملة دعم مستشفى الأطفال',
  //       image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
  //       managerName: 'مروان حمزة',
  //       membersCount: 15,
  //       equipment: 'مستلزمات طبية، أقنعة، قفازات',
  //       time: 'الإثنين الساعة 11 صباحًا',
  //       description: 'حملة إسعافات أولية لدعم مستشفى الأطفال.',
  //       phoneNumber: '0934001122',
  //     ),
  //     Hamla(
  //       teamName: 'حملة نظافة حديقة تشرين',
  //       image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
  //       managerName: 'سمر ديوب',
  //       membersCount: 18,
  //       equipment: 'أدوات نظافة، أكياس قمامة',
  //       time: 'الثلاثاء الساعة 8 صباحًا',
  //       description: 'تنظيف حديقة تشرين وتحسين مظهرها العام.',
  //       phoneNumber: '0934223344',
  //     ),
  //     Hamla(
  //       teamName: 'حملة صيانة مدارس دمشق',
  //       image: 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
  //       managerName: 'باسل شلهوب',
  //       membersCount: 10,
  //       equipment: 'أدوات صيانة، دهانات، فرش',
  //       time: 'الأربعاء الساعة 9 صباحًا',
  //       description: 'ترميم وصيانة مدارس دمشق قبل بداية العام الدراسي.',
  //       phoneNumber: '0934556677',
  //     ),
  //   ];

  //   filteredDonations.value = donations;
  // }

  // void searchByTeamName(String query) {
  //   if (query.isEmpty) {
  //     filteredDonations.value = donations;
  //   } else {
  //     filteredDonations.value =
  //         donations.where((d) => d.teamName!.contains(query)).toList();
  //   }
  // }
}
