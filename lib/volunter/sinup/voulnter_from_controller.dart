import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class VolunteerFormController extends GetxController {
  File? profileImage;
  String? profileImageUrl;

  final fullNameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final nationalityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  DateTime? birthDate;

  String? selectedSpecialty;
  final List<String> specialties = [
    'طب بشري',
    'تمريص',
    'شبكات',
    'معلوماتية',
    'اعمال حرة ',
  ];

  @override
  void onInit() {
    super.onInit();
    // fetchVolunteerData();
  }

  Future<void> updateProfile() async {
    final url = Uri.parse(
      'http://volunteer.test-holooltech.com/api/volunteer/profile/update',
    );

    var storage = Get.find<StorageService>().getVolunteerTokenInfo().volunteer;

    // log(json.encode(storage.getVolunteerTokenInfo().volunteer));

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}',
    });

    // إضافة الحقول النصية
    request.fields['full_name'] = storage!.fullName!;
    request.fields['email'] = storage.email!;
    request.fields['phone'] = phoneController.text;
    request.fields['nationality'] = nationalityController.text;
    request.fields['national_number'] = nationalIdController.text;
    request.fields['specialization_id'] = storage.specializationId.toString();
    request.fields['birth_date'] = birthDateController.text;

    // إضافة الصورة
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        profileImage!.path,
        filename: basename(profileImage!.path),
      ),
    );

    // إذا احتجت لإضافة توكن في الهيدر:
    // request.headers['Authorization'] = 'Bearer YOUR_TOKEN';

    try {
      final response = await request.send();

      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('تم التحديث بنجاح');
        final responseData = await response.stream.bytesToString();
        print(responseData);
        Get.offAllNamed('/buttom_navigation_bar_voulnter');
      } else {
        print('فشل التحديث: ${response.statusCode}');
        final responseData = await response.stream.bytesToString();
        print(responseData);
      }
    } catch (e) {
      print('حدث خطأ: $e');
    }
  }

  Future<void> fetchVolunteerData() async {
    final url = Uri.parse("https://volunteer.asr.sy/api/volunteer/profile");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];

        fullNameController.text = data['full_name'] ?? '';
        nationalIdController.text = data['national_number'] ?? '';
        phoneController.text = data['phone'] ?? '';
        emailController.text = data['email'] ?? '';

        final birthDateStr = data['birth_date'];
        if (birthDateStr != null) {
          birthDate = DateTime.parse(birthDateStr);
          birthDateController.text = DateFormat(
            'yyyy-MM-dd',
          ).format(birthDate!);
        }

        profileImageUrl = "https://volunteer.asr.sy/${data['image']}";
        selectedSpecialty = data['specialization']?['name'];

        update();
      } else {
        Get.snackbar("خطأ", "فشل في تحميل البيانات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء جلب البيانات: $e");
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage = File(picked.path);
      update();
    }
  }

  Future<void> pickBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 18),
    );
    if (picked != null) {
      birthDate = picked;
      birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  bool validateFormWithMessages() {
    if (profileImage == null && profileImageUrl == null) {
      Get.snackbar("خطأ", "يرجى اختيار صورة شخصية");
      return false;
    }

    final nationalId = nationalIdController.text.trim();
    if (!RegExp(r'^\d{11}$').hasMatch(nationalId)) {
      Get.snackbar("خطأ", "الرقم الوطني غير صحيح (يجب أن يكون 11 رقمًا)");
      return false;
    }

    final phone = phoneController.text.trim();
    if (!RegExp(r'^09\d{8}$').hasMatch(phone)) {
      Get.snackbar(
        "خطأ",
        "رقم الموبايل غير صحيح (يجب أن يبدأ بـ 09 ويتكون من 10 أرقام)",
      );
      return false;
    }

    if (nationalityController.text.trim().isEmpty) {
      Get.snackbar("خطأ", "حقل الجنسية فارغ");
      return false;
    }

    if (birthDate == null) {
      Get.snackbar("خطأ", "يرجى اختيار تاريخ الميلاد");
      return false;
    }

    final age = DateTime.now().year - birthDate!.year;
    if (age < 18) {
      Get.snackbar("خطأ", "يجب أن يكون المتطوع بعمر 18 أو أكثر");
      return false;
    }

    return true;
  }
}
