// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class detail_voulnter_controller extends GetxController {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();

//   final formKey = GlobalKey<FormState>();
//   var selectedProvince = ''.obs;
//   var specializationController = TextEditingController();
//   var avatarPath = ''.obs;

//   final List<String> provinces = [
//     'دمشق',
//     'ريف دمشق',
//     'حلب',
//     'حمص',
//     'حماة',
//     'إدلب',
//     'اللاذقية',
//     'طرطوس',
//     'دير الزور',
//     'الرقة',
//     'حسكة',
//     'السويداء',
//     'درعا',
//   ];

//   Future pickImage() async {
//     final picker = ImagePicker();
//     final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) avatarPath.value = picked.path;
//   }

//   void save() {
//     if (avatarPath.value.isEmpty) {
//       Get.snackbar(
//         'تنبيه',
//         'يرجى اختيار صورة شخصية',
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     if (!formKey.currentState!.validate()) {
//       // الفورم فيه أخطاء
//       return;
//     }

//     if (selectedProvince.value.isEmpty) {
//       Get.snackbar(
//         'تنبيه',
//         'يرجى اختيار المحافظة',
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     // ✅ كل شيء صحيح، نحدث البيانات
//     nameController.text = nameController.text.trim();
//     phoneController.text = phoneController.text.trim();
//     specializationController.text = specializationController.text.trim();
//     selectedProvince.value = selectedProvince.value;
//     avatarPath.value = avatarPath.value;

//     // ✅ عرض رسالة نجاح
//     Get.snackbar(
//       'نجاح',
//       'تم تحديث المعلومات بنجاح',
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );

//     Future.delayed(const Duration(seconds: 1), () {
//       Get.offAllNamed('/buttom_navigation_bar_voulnter');
//     });
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       nameController.text = args['name'] ?? '';
//       phoneController.text = args['phone'] ?? ''; // أو حقل الهاتف لو مررته
//     }
//   }
// }
// detail_voulnter_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:athar_project/volunter/details_about_voulnter/voulnter_profile_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DetailVoulnterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var nationalNumberController = TextEditingController();
  var birthDateController = TextEditingController();
  var specializationController = TextEditingController();

  var selectedProvince = ''.obs;
  var avatarPath = ''.obs;
  var isLoading = false.obs;

  var profile = Rxn<Data>();

  final List<String> provinces = [
    'طب بشري',
    'تمريص',
    'شبكات',
    'معلوماتية',
    'اعمال حرة ',
  ];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) avatarPath.value = picked.path;
  }

  Future<void> fetchVolunteerProfile() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse("http://volunteer.test-holooltech.com/api/volunteer/profile"),
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}",
        },
      );

      if (response.statusCode == 200) {
        final data = voulnterProfileModelFromJson(response.body);
        if (data.success == true && data.data != null) {
          profile.value = data.data!;

          nameController.text = data.data!.fullName ?? '';
          phoneController.text = data.data!.phone ?? '';
          emailController.text = data.data!.email ?? '';
          nationalNumberController.text = data.data!.nationalNumber ?? '';
          birthDateController.text = data.data!.birthDate ?? '';
          specializationController.text = data.data!.specialization?.name ?? '';
          selectedProvince.value = data.data!.nationality ?? '';
        }
      } else {
        Get.snackbar('خطأ', 'فشل تحميل البيانات');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الاتصال: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVolunteerProfile() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final uri = Uri.parse(
      "http://volunteer.test-holooltech.com/api/volunteer/profile/update",
    );
    final request = http.MultipartRequest("POST", uri);

    request.fields['full_name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['nationality'] = selectedProvince.value;
    request.fields['national_number'] = nationalNumberController.text;
    request.fields['birth_date'] = birthDateController.text;
    request.fields['spaciliazation'] = specializationController.text;

    if (avatarPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('image', avatarPath.value),
      );
    }

    request.headers['Authorization'] =
        "Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}";

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final resBody = await http.Response.fromStream(response);
        final decoded = json.decode(resBody.body);

        if (decoded['success'] == true) {
          Get.snackbar(
            "تم التحديث",
            "تم تعديل معلوماتك بنجاح",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          await fetchVolunteerProfile();
          Get.back();
        } else {
          Get.snackbar(
            "فشل",
            decoded['message'] ?? 'فشل التحديث',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "خطأ",
          "فشل التعديل",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء التحديث: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchVolunteerProfile();
  }
}



// class DetailVoulnterController extends GetxController {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final specializationController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   var selectedProvince = ''.obs;
//   var avatarPath = ''.obs;
//   var isLoading = false.obs;

//   final List<String> provinces = [
//     'دمشق',
//     'ريف دمشق',
//     'حلب',
//     'حمص',
//     'حماة',
//     'إدلب',
//     'اللاذقية',
//     'طرطوس',
//     'دير الزور',
//     'الرقة',
//     'حسكة',
//     'السويداء',
//     'درعا',
//   ];

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) avatarPath.value = picked.path;
//   }

//   Future<void> fetchVolunteerProfile() async {
//     try {
//       isLoading.value = true;

//       final response = await http.get(
//         Uri.parse("http://volunteer.test-holooltech.com/api/volunteer/profile"),
//         headers: {
//           "Accept": "application/json",
//           "Authorization": "Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}", // عدل هنا
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = voulnterProfileModelFromJson(response.body);
//         if (data.success == true && data.data != null) {
//           final profile = data.data!;
//           nameController.text = profile.fullName ?? '';
//           phoneController.text = profile.phone ?? '';
//           specializationController.text = profile.specialization?.name ?? '';
//           // المحافظة غير موجودة بالـ API - إذا بدك تخزنها محلياً
//         }
//       } else {
//         Get.snackbar('خطأ', 'فشل تحميل البيانات');
//       }
//     } catch (e) {
//       Get.snackbar('خطأ', 'حدث خطأ أثناء الاتصال: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchVolunteerProfile();
//   }
// }

