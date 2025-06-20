import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/admin/model/CompagineAdmin_model.dart';
import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  var searchQuery = '';
  int currentIndex = 1;

  final campaigns = List.generate(
    9,
    (index) => {
      'name': 'اسم الحملة $index',
      'type': 'نوع الحملة',
      'date': '18/5/2020',
      'amount': '200\$',
      'participants': '${index + 10} مشارك',
      'image': 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
    },
  );

  // قائمة الحملات المنتهية
  var finishedCampaigns = <Map<String, String>>[];

  // تصفية الحملات بناءً على البحث
  List<Map<String, String>> get filteredCampaigns {
    if (searchQuery.isEmpty) return campaigns;
    return campaigns
        .where(
          (campaign) =>
              campaign['name']!.contains(searchQuery) ||
              campaign['type']!.contains(searchQuery),
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

  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  CompagineAdminModel campaignsModel = CompagineAdminModel();
  CompagineAdminModel campaignsPendingModel = CompagineAdminModel();
  CompagineAdminModel campaignsDoneModel = CompagineAdminModel();

  Future<CompagineAdminModel> getCampaigns() async {
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',

        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "get-employee-campaigns",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "getCampaigns response body");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        campaignsDoneModel.data ??= [];
        campaignsPendingModel.data ??= [];
        for (var element in CompagineAdminModel.fromJson(data).data!) {
          if (element.status!.toLowerCase() == 'pending') {
            campaignsPendingModel.data!.add(element);
          } else {
            campaignsDoneModel.data!.add(element);
          }
        }
        campaignsDoneModel.data ??= [];
        campaignsPendingModel.data ??= [];
        return CompagineAdminModel.fromJson(data);
      }
      return CompagineAdminModel();
    } catch (e) {
      log(e.toString(), name: "getCampaigns catch error");
      campaignsDoneModel.data = [];
      campaignsPendingModel.data = [];
      return CompagineAdminModel();
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
}


// import 'dart:convert';
// import 'dart:developer';

// import 'package:athar_project/network.dart';
// import 'package:athar_project/volunter/core/model/campaigns_details_model.dart';
// import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class Campaigns {
//   final String? nameHamla;
//   final String? type;
//   final String? date;
//   final int? amount;
//   final int? participants;
//   final String? image;

//   Campaigns({
//     this.amount,
//     this.date,
//     this.image,
//     this.nameHamla,
//     this.participants,
//     this.type,
//   });
// }

// class CampaignsController extends GetxController {
//   bool isLoading = true;
//   isLoadingSet(bool value) {
//     isLoading = value;
//     update();
//   }

//   CampaignDetailsModel campaignDetailsModel = CampaignDetailsModel();
//   Future<CampaignDetailsModel> getCampaignDetailsModel() async {
//     try {
//       Map<String, String> authHeaders = {
//         'Accept': 'application/json',
//         'Content-type': 'application/json',
//         'Authorization':
//             'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
//         //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
//       };
//       final http.Response response = await NetworkUtils.get(
//         url: "get-employee-campaigns",
//         headers: authHeaders,
//       );

//       log(response.body.toString(), name: "get-employee-campaigns");
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         return CampaignDetailsModel.fromJson(data);
//       }
//       return CampaignDetailsModel();
//     } catch (e) {
//       log(e.toString(), name: "get-employee-campaigns error");
//       return CampaignDetailsModel();
//     } finally {}
//   }




//   void finishCampaign(Map<String, String> campaign) {
//     campaigns.remove(campaign);
//     finishedCampaigns.add(campaign);
//     update();
//   }


//   void addCampaign(Map<String, String> newCampaign) {
//     Campaigns.add(newCampaign);
//     update();
//   }

//   @override
//   Future onInit() async {
//     super.onInit();
//     isLoadingSet(true);
//     campaignDetailsModel = await getCampaignDetailsModel();
//     isLoadingSet(false);
//     // loadDonations();
//   }
// }
// // class HomePageController extends GetxController {
// //   var searchQuery = ''.obs;
// //   int currentIndex = 1;

// //   final campaigns =
// //       List.generate(
// //         9,
// //         (index) => {
// //           'name': 'اسم الحملة $index',
// //           'type': 'نوع الحملة',
// //           'date': '18/5/2020',
// //           'amount': '200\$',
// //           'participants': '${index + 10} مشارك',
// //           'image':
// //               'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
// //         },
// //       ).obs;

// //   // قائمة الحملات المنتهية
// //   var finishedCampaigns = <Map<String, String>>[].obs;

// //   // تصفية الحملات بناءً على البحث
// //   List<Map<String, String>> get filteredCampaigns {
// //     if (searchQuery.value.isEmpty) return campaigns;
// //     return campaigns
// //         .where(
// //           (campaign) =>
// //               campaign['name']!.contains(searchQuery.value) ||
// //               campaign['type']!.contains(searchQuery.value),
// //         )
// //         .toList();
// //   }

// //   void finishCampaign(Map<String, String> campaign) {
// //     campaigns.remove(campaign);
// //     finishedCampaigns.add(campaign);
// //     update();
// //   }

// //   void addCampaign(Map<String, String> newCampaign) {
// //     campaigns.add(newCampaign);
// //     update();
// //   }
// // }
