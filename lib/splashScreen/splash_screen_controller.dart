import 'dart:developer';

import 'package:athar_project/employee_payment/Donation/donation_add_page.dart';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabaroat_TablePage.dart';
import 'package:athar_project/employee_payment/payment_employee_main_page.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  @override
  Future onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(DonationAddPage());
    Get.offAll(DonationsTablePage());
    log(
      Get.find<StorageService>().getAccountType(),
      name: "Get.find<StorageService>().getAccountType()",
    );
    if (Get.find<StorageService>().getAccountType() ==
        StorageService.Volunteer_User_Account)
      Get.offAllNamed("/buttom_navigation_bar_voulnter");
    else if (Get.find<StorageService>().getAccountType() ==
        StorageService.Employee_Account)
      Get.offAllNamed("/buttom/navigation/bar/page");
    else if (Get.find<StorageService>().getAccountType() ==
        StorageService.Payment_Employee_Account)
      Get.offAll(PaymentEmployeeMainPage());
    else
      Get.offAllNamed("/homepage");
  }
}
