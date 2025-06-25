import 'dart:developer';

import 'package:athar_project/admin/Attendance/Attendance.dart';
import 'package:athar_project/admin/Notifcation/notification.dart';
import 'package:athar_project/admin/Volunteer_Attendance/Volunteer_Attendance.dart';
import 'package:athar_project/admin/chat_Admin/CampaignChatPage.dart';
import 'package:athar_project/admin/ComplaintDetailsPage.dart';
import 'package:athar_project/admin/login/Login_admin.dart';
import 'package:athar_project/admin/AddHamla/add_hamla.dart';
import 'package:athar_project/admin/buttom_navigation_bar/buttom_navigation_bar_page.dart';
import 'package:athar_project/admin/profile_for_admin/admin_profile.dart';
import 'package:athar_project/admin/profile_for_admin/edit_profile_admin.dart';
import 'package:athar_project/admin/homepage/homepageadmin.dart';
import 'package:athar_project/homepage/HomePage.dart';
import 'package:athar_project/splashScreen/splash_screen.dart';
import 'package:athar_project/volunter/buttom_navigation_bar/buttom_navigation_bar_voulnter.dart';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:athar_project/volunter/details_about_voulnter/update_details_voulnter.dart';
// import 'package:athar_project/volunter/edit_profile_voulnter.dart';
import 'package:athar_project/volunter/homepage/homepage_voulnter.dart';
import 'package:athar_project/volunter/join_with_hamla/joined_with_hamla_controller.dart';
import 'package:athar_project/volunter/login/login_voulnter.dart';
import 'package:athar_project/volunter/details_about_voulnter/profile_voulnter_page.dart';
import 'package:athar_project/volunter/shakawa/shakawa.dart';
import 'package:athar_project/volunter/sinup/sinup_voulnter.dart';
import 'package:athar_project/volunter/tabroat/tabroat.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:athar_project/admin/homepage/home_page_controller.dart';

void main() async {
  try {
    await GetStorage.init();

    Get.put(StorageService());
    Get.put(HomePageController());
    Get.put(JoinedCampaignController());
    Get.put(DetailVoulnterController());
  } catch (e) {
    log(e.toString());
  }

  runApp(const MyApp());
  // log(Get.find<StorageService>().getVolunteerTokenInfo().token!, name: "Token");
  // log(Get.find<StorageService>().getEmployeeTokenInfo().token!, name: "Token");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final isLoggedIn = box.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ProductView(),
      initialRoute: "/splashscreen",
      getPages: [
        GetPage(name: "/splashscreen", page: () => const SplashScreen()),
        GetPage(
          name: "/buttom/navigation/bar/page",
          page: () => const ButtomNavigationBarPage(),
        ),
        GetPage(name: "/homepage", page: () => const HomePage()),
        GetPage(name: "/Login_admin", page: () => Login_admin()),
        GetPage(name: "/Homepageadmin", page: () => const Homepageadmin()),
        GetPage(name: "/AdminProfilePage", page: () => AdminProfilePage()),

        GetPage(name: '/profile', page: () => EditAdminProfilePage()),
        GetPage(name: '/add_hamla', page: () => AddHamlaPage()),
        GetPage(
          name: '/Volunteer_Attendance',
          page: () => Volunteer_Attendance(),
        ),

        // GetPage(
        //   name: '/complaint-details',
        //   page: () => const ComplaintDetailsPage(),
        // ),
        GetPage(
          name: '/CampaignChatPage',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return CampaignChatPage(campaignName: args['campaignName']);
          },
        ),

        GetPage(name: "/Login_voulnter", page: () => login_voulnter()),
        GetPage(name: "/sinup_voulnter", page: () => sinup_voulnter()),
        GetPage(name: "/detail_voulnter", page: () => update_detail_voulnter()),
        GetPage(name: "/homepage_voulnter", page: () => homepage_voulnter()),
        GetPage(
          name: "/buttom_navigation_bar_voulnter",
          page: () => const buttom_navigation_bar_voulnter(),
        ),

        GetPage(name: "/Tabroat", page: () => Tabroat()),
        GetPage(name: "/Shakawa", page: () => ComplaintsPage()),
        GetPage(name: "/editProfile", page: () => ProfileVoulnter()),

        // GetPage(
        //   name: "/edit_profile_voulnter",
        //   page: () => EditProfileVoulnter(),
        // ),
        GetPage(
          name: "/NotificationsPage",
          page: () => NotificationsPage(notifications: []),
        ),
      ],
    );
  }
}
