import 'dart:io';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileVoulnter extends StatelessWidget {
  ProfileVoulnter({Key? key}) : super(key: key);

  final detail_voulnter_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الحساب الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // الصورة الشخصية
            Obx(() {
              return CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    controller.avatarPath.value.isNotEmpty
                        ? FileImage(File(controller.avatarPath.value))
                        : const AssetImage(
                              'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
                            )
                            as ImageProvider,
              );
            }),
            const SizedBox(height: 20),

            // الاسم الكامل
            InfoTile(
              title: 'الاسم الكامل',
              value:
                  controller.nameController.text.isNotEmpty
                      ? controller.nameController.text
                      : 'غير محدد',
              icon: Icons.person,
            ),
            const SizedBox(height: 15),

            // رقم الهاتف
            InfoTile(
              title: 'رقم الهاتف',
              value:
                  controller.phoneController.text.isNotEmpty
                      ? controller.phoneController.text
                      : 'غير محدد',
              icon: Icons.phone,
            ),
            const SizedBox(height: 15),

            // المحافظة
            Obx(
              () => InfoTile(
                title: 'المحافظة',
                value:
                    controller.selectedProvince.value.isNotEmpty
                        ? controller.selectedProvince.value
                        : 'غير محدد',
                icon: Icons.location_city,
              ),
            ),
            const SizedBox(height: 15),

            // التخصص
            InfoTile(
              title: 'التخصص',
              value:
                  controller.specializationController.text.isNotEmpty
                      ? controller.specializationController.text
                      : 'غير محدد',
              icon: Icons.school,
            ),
            const SizedBox(height: 30),

            // زر التعديل
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/detail_voulnter');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
              ),
              child: const Text(
                'تعديل المعلومات',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoTile({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF003366)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
