import 'package:athar_project/volunter/core/model/campaigns_details_model.dart';
import 'package:get/get.dart';
import '../homepage/home_page_controller.dart';

class JoinedCampaignController extends GetxController {
  var joinedCampaigns = <Data>[];

  Future<void> joinCampaign(Data data) async {
    joinedCampaigns.add(data);
    update();
  }

  void clearCampaign() {
    joinedCampaigns.clear();
    update();
  }
}
