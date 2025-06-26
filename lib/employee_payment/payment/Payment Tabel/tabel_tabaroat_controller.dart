import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabaroat_model.dart';
import 'package:athar_project/volunter/storage/volunteer_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DonationTableController extends GetxController {
  List<Donation> donations = [];
  bool isLoading = false;
  String totalBalance = "0";
  File? selectedImage;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update(); // لتحديث GetBuilder
    }
  }

  Future<void> fetchDonations() async {
    try {
      isLoading = true;
      update();
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
        //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
      };
      final response = await http.get(
        Uri.parse("https://volunteer.test-holooltech.com/api/financials"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        log(response.body.toString(), name: "fetchDonations response.body");
        final data = json.decode(response.body);
        totalBalance = data['total_amount'];
        donations =
            (data['donations'] as List)
                .map((e) => Donation.fromJson(e))
                .toList();
      } else {
        Get.snackbar("خطأ", "فشل تحميل التبرعات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء التحميل");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateDonation(Donation updated) async {
    final url =
        "https://volunteer.test-holooltech.com/api/financials/${updated.id}";

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };

    try {
      if (selectedImage == null) {
        // ✅ إذا ما في صورة، نستخدم PUT عادي
        final response = await http.put(
          Uri.parse(url),
          headers: authHeaders,
          // headers: {
          //   'Authorization': 'Bearer $token',
          //   'Accept': 'application/json',
          //   'Content-Type': 'application/json',
          // },
          body: jsonEncode({
            "amount": updated.amount,
            "type": updated.type,
            "status": updated.status,
            "payment_date": updated.paymentDate,
            "name": updated.benefactorName, // ✅ تصحيح الاسم
            "phone": updated.benefactorPhone ?? "", // ✅ تصحيح الاسم
            "transfer_number": updated.transferNumber ?? "",
          }),
        );

        if (response.statusCode == 200) {
          Get.snackbar("تم", "تم تعديل التبرع بنجاح");
          fetchDonations();
        } else {
          print("Update failed: ${response.body}");
          Get.snackbar("خطأ", "فشل تعديل التبرع");
        }
      } else {
        // ✅ إذا في صورة، نستخدم MultipartRequest
        final request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(authHeaders);
        request.fields['_method'] = 'PUT';
        request.fields['amount'] = updated.amount;
        request.fields['type'] = updated.type;
        request.fields['status'] = updated.status;
        request.fields['payment_date'] = updated.paymentDate;
        request.fields['name'] = updated.benefactorName; // ✅ تصحيح الاسم
        request.fields['phone'] =
            updated.benefactorPhone ?? ''; // ✅ تصحيح الاسم
        request.fields['transfer_number'] = updated.transferNumber ?? '';

        request.files.add(
          await http.MultipartFile.fromPath('image', selectedImage!.path),
        );

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          Get.snackbar("تم", "تم تعديل التبرع مع صورة");
          selectedImage = null;
          fetchDonations();
        } else {
          print("Update failed: ${response.body}");
          Get.snackbar("خطأ", "فشل تعديل التبرع مع صورة");
        }
      }
    } catch (e) {
      Get.snackbar("خطأ", "مشكلة في الاتصال بالسيرفر");
    } finally {
      update();
    }
  }

  Future<void> deleteDonation(int id) async {
    final url = "https://volunteer.test-holooltech.com/api/financials/$id";
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer ${Get.find<StorageService>().getEmployeeTokenInfo().token!}',
      //هي الكلمة بتنحط قبل ال token ليش ؟ لانو santaks
    };
    try {
      final response = await http.delete(Uri.parse(url), headers: authHeaders);

      if (response.statusCode == 200) {
        Get.snackbar("تم", "تم حذف التبرع");
        fetchDonations();
      } else {
        print("Delete failed: ${response.body}");
        Get.snackbar("خطأ", "فشل الحذف");
      }
    } catch (e) {
      Get.snackbar("خطأ", "مشكلة في الاتصال بالحذف");
    }
  }
}
