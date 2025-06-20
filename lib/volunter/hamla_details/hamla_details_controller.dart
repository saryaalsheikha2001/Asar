import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/network.dart';
import 'package:athar_project/volunter/core/model/campaigns_details_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HamlaDetailsController extends GetxController {
  bool isLoading = false;

  isLoadingSet(bool value) {
    isLoading = value;
    update();
  }

  final int id;

  HamlaDetailsController(this.id);

  CampaignDetailsModel campaignDetailsModel = CampaignDetailsModel();
  Future<CampaignDetailsModel> getCampaignDetails() async {
    isLoadingSet(true);
    try {
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };

      final http.Response response = await NetworkUtils.get(
        url: "campaigns/$id",
        headers: authHeaders,
      );
      log(response.body.toString(), name: "getCampaignDetails response body");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        campaignDetailsModel = CampaignDetailsModel.fromJson(data);
        return CampaignDetailsModel.fromJson(data);
      }
      return CampaignDetailsModel();
    } catch (e) {
      log(e.toString(), name: "getCampaignDetails catch error");
      return CampaignDetailsModel();
    } finally {
      isLoadingSet(false);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCampaignDetails();
  }
}
