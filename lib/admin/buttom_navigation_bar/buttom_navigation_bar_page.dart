import 'package:athar_project/admin/chat_Admin/CampaignChatPage.dart';
import 'package:athar_project/admin/Complaints_hmla_Page.dart';
// import 'package:athar_project/admin/buttom_navigation_bar/buttom_navigation_bar_page_controller.dart';
// import 'package:athar_project/admin/profile_for_admin/edit_profile_admin.dart';
// import 'package:athar_project/admin/homepageadmin.dart';
// import 'package:athar_project/donation_admin.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ButtomNavigationBarPage
//     extends GetView<ButtomNavigationBarPageController> {
//   const ButtomNavigationBarPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ButtomNavigationBarPageController>(
//       init: ButtomNavigationBarPageController(),
//       builder: (controller) {
//         return Scaffold(
//           bottomNavigationBar: CupertinoTabBar(
//             backgroundColor: Colors.white,
//             currentIndex: controller.currentIndex,
//             activeColor: const Color(0xff6C63FF),
//             inactiveColor: CupertinoColors.systemGrey2,
//             onTap: (value) {
//               // if (value == 1 &&
//               //     !Get.find<UserPermissionsControllerRepo>()
//               //         .getUserPermissionByKey(
//               //             UserPermissionsEnum.read_inspections)) return;
//               // if (value == 3 &&
//               //     !Get.find<UserPermissionsControllerRepo>()
//               //         .getUserPermissionByKey(
//               //             UserPermissionsEnum.read_quotation)) return;
//               controller.currentIndex = value;
//               controller.update();
//             },
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.report),
//                 backgroundColor:
//                     controller.currentIndex == 0
//                         ? Color.fromRGBO(0, 51, 102, 1)
//                         : Colors.grey,
//                 label: 'الشكاوى',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.campaign),
//                 backgroundColor:
//                     controller.currentIndex == 1
//                         ? Color.fromRGBO(0, 51, 102, 1)
//                         : Colors.grey,
//                 label: 'الحملات',
//               ),
//               // const BottomNavigationBarItem(
//               //   icon: Icon(CupertinoIcons.exclamationmark_bubble, size: 25),
//               //   label: 'Issues',
//               // ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 backgroundColor:
//                     controller.currentIndex == 2
//                         ? Color.fromRGBO(0, 51, 102, 1)
//                         : Colors.grey,
//                 label: 'حسابي',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 backgroundColor:
//                     controller.currentIndex == 3
//                         ? Color.fromRGBO(0, 51, 102, 1)
//                         : Colors.grey,
//                 label: 'التبرعات ',
//               ),
//             ],
//           ),
//           body:
//               controller.currentIndex == 1
//                   ? Homepageadmin()
//                   : controller.currentIndex == 0
//                   ? ComplaintsPage()
//                   :controller.currentIndex==2
//                   ?ProfilePage()
//                   : controller.currentIndex == 3
//                     ? DonationsPage()

//         );
//       },
//     );
//   }
// }

import 'package:athar_project/admin/chat_Admin/CampaignChatPage.dart';
import 'package:athar_project/admin/Complaints_hmla_Page.dart';
import 'package:athar_project/admin/buttom_navigation_bar/buttom_navigation_bar_page_controller.dart';
import 'package:athar_project/admin/profile_for_admin/admin_profile.dart';
import 'package:athar_project/admin/profile_for_admin/edit_profile_admin.dart';
import 'package:athar_project/admin/homepageadmin.dart';
import 'package:athar_project/admin/donation_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtomNavigationBarPage
    extends GetView<ButtomNavigationBarPageController> {
  const ButtomNavigationBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtomNavigationBarPageController>(
      init: ButtomNavigationBarPageController(),
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex,
            activeColor: const Color(0xff6C63FF),
            inactiveColor: CupertinoColors.systemGrey2,
            onTap: (value) {
              controller.currentIndex = value;
              controller.update();
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: 'الشكاوى',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.campaign),
                label: 'الحملات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'التبرعات',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
            ],
          ),
          body: _getBody(controller.currentIndex),
        );
      },
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        // return Homepageadmin();
        return ComplaintsPage();
      case 1:
        // return ComplaintsPage();
        return Homepageadmin();

      case 2:
        return DonationsPage();
      case 3:
        // return DonationsPage();
        return AdminProfilePage();
      default:
        return Center(child: Text('لا توجد بيانات'));
    }
  }
}
