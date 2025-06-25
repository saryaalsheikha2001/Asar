import 'dart:convert';
import 'dart:developer';
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
    'اعمال حرة',
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
        final data = profileVoulnterModelFromJson(response.body);

        profile.value = data.data;

        nameController.text = data.data.fullName;
        phoneController.text = data.data.phone ?? '';
        emailController.text = data.data.email;
        nationalNumberController.text = data.data.nationalNumber ?? '';
        birthDateController.text = data.data.birthDate ?? '';
        specializationController.text = data.data.specialization.name;
        selectedProvince.value = data.data.nationality ?? '';
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
    request.fields['specialization_id'] = '1';

    if (avatarPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('image', avatarPath.value),
      );
    }

    request.headers['Authorization'] =
        "Bearer ${Get.find<StorageService>().getVolunteerTokenInfo().token!}";

    try {
      final response = await request.send();

      log(response.statusCode.toString(), name: "response.statusCode");
      log(await response.stream.bytesToString(), name: "response.stream");

      if (response.statusCode == 200) {
        // final resBody = await http.Response.fromStream(response);
        // final decoded = json.decode(resBody.body);

        // if (decoded['success'] == true) {
        Get.snackbar(
          "تم التحديث",
          "تم تعديل معلوماتك بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await fetchVolunteerProfile();
        Get.back(result: true);
        // } else {
        //   Get.snackbar(
        //     "فشل",
        //     decoded['message'] ?? 'فشل التحديث',
        //     backgroundColor: Colors.red,
        //     colorText: Colors.white,
        //   );
        // }
      } else {
        print(response);
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
