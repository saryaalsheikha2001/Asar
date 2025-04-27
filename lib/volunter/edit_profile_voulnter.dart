import 'package:athar_project/volunter/edit_profile_voulnter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileVoulnter extends StatelessWidget {
  EditProfileVoulnter({Key? key}) : super(key: key);

  final EditProfileVoulnterController controller = Get.put(
    EditProfileVoulnterController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'الحساب الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // الاسم
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  hintText: 'ادخل اسمك الكامل',
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'يرجى إدخال الاسم'
                            : null,
              ),
              const SizedBox(height: 15),

              // رقم الهاتف
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف المحمول',
                  hintText: '09XXXXXXXX',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم الهاتف';
                  }
                  final pattern = r'^09\d{8}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'رقم الهاتف يجب أن يبدأ بـ09 ويتكون من 10 أرقام';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // المحافظة
              Obx(
                () => DropdownButtonFormField<String>(
                  value:
                      controller.selectedProvince.value.isEmpty
                          ? null
                          : controller.selectedProvince.value,
                  items:
                      controller.provinces
                          .map(
                            (province) => DropdownMenuItem<String>(
                              value: province,
                              child: Text(province),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) =>
                          controller.selectedProvince.value = value ?? '',
                  decoration: const InputDecoration(labelText: 'المحافظة'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'يرجى اختيار المحافظة'
                              : null,
                ),
              ),
              const SizedBox(height: 15),

              // التخصص
              TextFormField(
                controller: controller.specializationController,
                decoration: const InputDecoration(
                  labelText: 'التخصص',
                  hintText: 'ادخل تخصصك',
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'يرجى إدخال التخصص'
                            : null,
              ),
              const SizedBox(height: 30),

              // زر الحفظ
              ElevatedButton(
                onPressed: () => controller.saveProfile(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003366),
                  shape: StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ),
                child: const Text(
                  'حفظ التعديلات',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
