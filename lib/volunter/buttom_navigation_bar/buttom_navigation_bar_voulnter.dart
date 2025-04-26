import 'package:athar_project/volunter/buttom_navigation_bar/buttom_navigation_bar_voulnter_controller.dart';
import 'package:athar_project/volunter/edit_profile_voulnter.dart';
import 'package:athar_project/volunter/homepage_voulnter.dart';
import 'package:athar_project/volunter/joined_with_hamla.dart';
import 'package:athar_project/volunter/shakawa.dart';
import 'package:athar_project/volunter/tabroat.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/cupertino.dart';

class buttom_navigation_bar_voulnter
    extends GetView<ButtomNavigationBarPageController_voulnter> {
  const buttom_navigation_bar_voulnter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtomNavigationBarPageController_voulnter>(
      init: ButtomNavigationBarPageController_voulnter(),
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
                icon: Icon(Icons.assignment_turned_in),
                label: 'مشترك',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'التبرعات',
              ),
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
        return homepage_voulnter(); // الحملات
      case 1:
        return Tabroat();
      case 2:
        return JoinedCampaignPage(); // صفحة الحملات المشترك فيها
      case 3:
        return EditProfileVoulnter();
      case 4:
        return Shakawa();
      default:
        return Center(child: Text('لا توجد بيانات'));
    }
  }
}
