import 'package:athar_project/volunter/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  @override
  Future onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 3));
    if (Get.find<StorageService>().getAccountType() ==
        StorageService.Volunteer_User_Account)
      Get.offAllNamed("/buttom_navigation_bar_voulnter");
    else if (Get.find<StorageService>().getAccountType() ==
        StorageService.Employee_Account)
      Get.offAllNamed("/buttom/navigation/bar/page");
    else
      Get.offAllNamed("/homepage");
  }
}
