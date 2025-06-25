import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileVoulnter extends StatelessWidget {
  ProfileVoulnter({Key? key}) : super(key: key);

  final DetailVoulnterController controller = Get.find();

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'غير محدد';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'غير محدد';
    }
  }

  String formatDateTime(DateTime? date) {
    if (date == null) return 'غير محدد';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الحساب الشخصي',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF003366),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;

        if (profile == null) {
          return const Center(
            child: Text(
              'لا توجد بيانات للعرض',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        final imageUrl =
            profile.image != null && profile.image!.isNotEmpty
                ? "http://volunteer.test-holooltech.com/uploads/logos/${profile.image}"
                : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl)
                    : const AssetImage(
                        'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
                      ) as ImageProvider,
              ),
              const SizedBox(height: 30),
              InfoTile(
                title: 'الاسم الكامل',
                value: profile.fullName,
                icon: Icons.person,
              ),
              InfoTile(
                title: 'الرقم الوطني',
                value: profile.nationalNumber ?? 'غير محدد',
                icon: Icons.credit_card,
              ),
              InfoTile(
                title: 'الجنسية',
                value: profile.nationality ?? 'غير محدد',
                icon: Icons.flag,
              ),
              InfoTile(
                title: 'رقم الهاتف',
                value: profile.phone ?? 'غير محدد',
                icon: Icons.phone,
              ),
              InfoTile(
                title: 'البريد الإلكتروني',
                value: profile.email,
                icon: Icons.email,
              ),
              InfoTile(
                title: 'تاريخ الميلاد',
                value: formatDate(profile.birthDate),
                icon: Icons.cake,
              ),
              InfoTile(
                title: 'التخصص',
                value: profile.specialization.name,
                icon: Icons.school,
              ),
              InfoTile(
                title: 'النقاط الكلية',
                value: profile.totalPoints.toString(),
                icon: Icons.star,
              ),
              InfoTile(
                title: 'تاريخ التسجيل',
                value: formatDateTime(profile.createdAt),
                icon: Icons.calendar_today,
              ),
              InfoTile(
                title: 'تاريخ آخر تحديث',
                value: formatDateTime(profile.updatedAt),
                icon: Icons.update,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final result = await Get.toNamed('/detail_voulnter');
                  if (result == true) {
                    await controller.fetchVolunteerProfile();
                  }
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(icon, color: const Color(0xFF003366)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.right,
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        textAlign: TextAlign.right,
      ),
      horizontalTitleGap: 0,
      minLeadingWidth: 24,
    );
  }
}
