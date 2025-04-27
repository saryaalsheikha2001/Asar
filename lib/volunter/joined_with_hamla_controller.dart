import 'package:athar_project/volunter/home_page_controller.dart';
import 'package:get/get.dart';

class JoinedCampaignController extends GetxController {
  // var currentCampaign = Hamla().obs; // حملة حالية
  var joinedCampaigns = <Hamla>[]; // حملات قديمة (قائمة)

  Future joinCampaign(Hamla hamla) async {
    // currentCampaign.value = hamla;
    joinedCampaigns.add(hamla); // تضيفها للقائمة
    update();
  }

  void clearCampaign() {
    // currentCampaign.value = Hamla();
    joinedCampaigns = [];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
