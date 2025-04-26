import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  @override
  Future onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 3)); 

    Get.offAllNamed("/homepage");
  }
}
