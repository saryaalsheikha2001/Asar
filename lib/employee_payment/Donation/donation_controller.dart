import 'dart:io';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class DonationAddController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final transferNumberController = TextEditingController();

  // استبدال typeController بـ selectedType كـ RxString مع قيمة افتراضية '1'
  var selectedType = 'حوالة'.obs;

  Rx<File?> receiptImage = Rx<File?>(null);
  var isLoading = false.obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      receiptImage.value = File(picked.path);
    }
  }

  Future<void> submitDonation() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedType.value.isEmpty) {
      Get.snackbar("تنبيه", "يرجى تعبئة جميع الحقول المطلوبة");
      return;
    }

    // تحقق من صحة قيمة النوع
    // if (selectedType.value != '1' && selectedType.value != '2') {
    //   Get.snackbar("تنبيه", "نوع التبرع يجب أن يكون حوالة أو كاش");
    //   return;
    // }

    isLoading.value = true;

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };

    try {
      var uri = Uri.parse(
        "http://volunteer.test-holooltech.com/api/financials",
      );
      var request = http.MultipartRequest("POST", uri);

      request.fields['name'] = nameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['amount'] = amountController.text;
      request.fields['transfer_number'] = transferNumberController.text;
      request.fields['type'] = selectedType.value;

      if (receiptImage.value != null) {
        var stream = http.ByteStream(
          DelegatingStream.typed(receiptImage.value!.openRead()),
        );
        var length = await receiptImage.value!.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: basename(receiptImage.value!.path),
        );
        request.files.add(multipartFile);
      }

      // request.headers['Accept'] = 'application/json';
      // request.headers['Authorization'] =
      //     'Bearer 40|GCbsq4GIEta0eyoaHmTPwyaUohlzmwvflMldTcHx2821aa1f';

      request.headers.addAll(authHeaders);

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      print("Response status: ${response.statusCode}");
      print("Response body: $resBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("نجاح", "تمت إضافة التبرع بنجاح");

        // تفريغ الحقول بعد الإرسال الناجح
        nameController.clear();
        phoneController.clear();
        amountController.clear();
        transferNumberController.clear();
        // selectedType.value = '1';
        receiptImage.value = null;
      } else {
        Get.snackbar("خطأ", "فشل في إرسال التبرع: $resBody");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الإرسال: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
