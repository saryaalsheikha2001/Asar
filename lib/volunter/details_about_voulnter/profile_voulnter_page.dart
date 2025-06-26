import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> generateCertificate() async {
    const apiUrl =
        'http://volunteer.test-holooltech.com/api/generateCertificate';
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: authHeaders);
      log(response.statusCode.toString(), name: "response.statusCode");
      log(
        json.decode(response.body)["message"].toString(),
        name: "response.body",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['message'];
        final path = data['certificate_path'];
        final fullUrl = 'http://volunteer.test-holooltech.com/$path';

        // اطلب صلاحية التخزين
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          BotToast.showText(
            text: "لم يتم منح إذن التخزين!' ",
            align: Alignment.center,
            contentColor: Colors.redAccent,
            textStyle: TextStyle(color: Colors.white),
          );
          return;
        }

        // حمّل الملف
        final pdfResponse = await http.get(Uri.parse(fullUrl));
        if (pdfResponse.statusCode == 200) {
          final bytes = pdfResponse.bodyBytes;
          final dir = await getExternalStorageDirectory();
          final downloadPath = '${dir!.path}/شهادة_تطوع.pdf';
          final file = File(downloadPath);
          await file.writeAsBytes(bytes);

          Get.snackbar(
            'تم الحفظ',
            'تم حفظ الشهادة في المسار:\n$downloadPath',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        } else {
          BotToast.showText(
            text: "تعذر تحميل ملف الشهادة ",
            align: Alignment.center,
            contentColor: Colors.redAccent,
            textStyle: TextStyle(color: Colors.white),
          );
        }
        // صفشلاشش30ممممم
      } else {
        final data = jsonDecode(response.body);
        BotToast.showText(
          text:
              " لا يمكنك إصدار شهادة لأن لديك أقل من 100 نقطة. حذث خطا اثناء تحميل الشهادة",
          align: Alignment.center,
          contentColor: Colors.redAccent,
          textStyle: TextStyle(color: Colors.white),
        );
      }
    } catch (e) {
      BotToast.showText(
        text: "تهذر الاتصال ب الخادم",
        align: Alignment.center,
        contentColor: Colors.redAccent,
        textStyle: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: generateCertificate,
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            tooltip: 'الحصول على شهادة حضور',
          ),
        ],
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
                backgroundImage:
                    imageUrl != null
                        ? NetworkImage(imageUrl)
                        : const AssetImage(
                              'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
                            )
                            as ImageProvider,
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
