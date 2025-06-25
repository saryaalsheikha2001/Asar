import 'dart:io';
import 'package:athar_project/admin/profile_for_admin/%D9%90Admin_profile_controller.dart';
import 'package:athar_project/admin/profile_for_admin/edit_profile_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfilePage extends StatelessWidget {
  // final controller = Get.put(AdminProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<AdminProfileController>(
        init: AdminProfileController(),
        builder: (controller) {
          // final user = controller.profile;
          if (controller.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                // صورة البروفايل
                Center(
                  child: _buildProfileImage(
                    controller.profileAdminModel.data?.image ?? "",
                    controller.pickedImage,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  controller.profileAdminModel.data?.fullName ?? "",
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // معلومات الحساب
                _infoTile(
                  "البريد الإلكتروني",
                  controller.profileAdminModel.data!.email,
                ),
                _infoTile(
                  "رقم الهاتف",
                  controller.profileAdminModel.data!.phone,
                ),
                _infoTile(
                  "الرقم الوطني",
                  controller.profileAdminModel.data!.nationalNumber,
                ),
                _infoTile(
                  "الوظيفة",
                  controller.profileAdminModel.data!.position,
                ),
                _infoTile(
                  "العنوان",
                  controller.profileAdminModel.data!.address,
                ),
                // _infoTile("الفريق", controller.profileAdminModel.data!.teamId),
                _infoTile(
                  "الاختصاص",
                  controller.profileAdminModel.data!.specializationId
                      .toString(),
                ),
                _infoTile(
                  "تاريخ الانتساب",
                  controller.profileAdminModel.data!.dateAccession.toString(),
                ),

                const SizedBox(height: 25),

                // زر التعديل
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => EditAdminProfilePage());
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "تعديل المعلومات الشخصية",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl, File? localImage) {
    ImageProvider imageProvider;

    if (localImage != null) {
      imageProvider = FileImage(localImage);
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = const AssetImage(
        "assets/images/photo_2025-04-16_14-38-02-removebg-preview.png",
      );
    }

    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.grey[300],
      backgroundImage: imageProvider,
    );
  }

  Widget _infoTile(String label, String? value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: 6),
          Text(
            value?.isNotEmpty == true ? value! : "-",
            style: AppTextStyles.value,
          ),
        ],
      ),
    );
  }
}

class AppTextStyles {
  static const titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const label = TextStyle(fontSize: 13, color: Colors.grey);
  static const value = TextStyle(fontSize: 15, color: Colors.black87);
}

class AppColors {
  static const primary = Color(0xFF003366); // لون شعار أثر التطوعي
}



                // _infoCard("الاسم الكامل", data.fullName),
                // _infoCard("البريد الإلكتروني", data.email),
                // _infoCard("الرقم الوطني", data.nationalNumber),
                // _infoCard("الوظيفة", data.position),
                // _infoCard("رقم الهاتف", data.phone),
                // _infoCard("العنوان", data.address),
                // _infoCard("تاريخ الانتساب", data.dateAccession),
                // _infoCard("الفريق", data.team),
                // _infoCard("الاختصاص", data.specialization),