import 'dart:io';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class detail_voulnter extends StatelessWidget {
  final controller = Get.put(detail_voulnter_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asar'),
        backgroundColor: const Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // الصورة
              Obx(() {
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          controller.avatarPath.value.isNotEmpty
                              ? FileImage(File(controller.avatarPath.value))
                                  as ImageProvider
                              : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.pickImage,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: const Color(0xFF003366),
                          child: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // الاسم الكامل
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  hintText: 'ادخل اسمك الكامل هنا',
                ),
                validator:
                    (v) => v == null || v.isEmpty ? 'يرجى إدخال الاسم' : null,
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
                validator: (v) {
                  if (v == null || v.isEmpty) return 'يرجى إدخال رقم الهاتف';
                  final pattern = r'^09\d{8}$';
                  if (!RegExp(pattern).hasMatch(v))
                    return 'رقم الهاتف يجب أن يبدأ بـ 09 ويتكون من 10 أرقام';
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // قائمة المحافظات
              Obx(
                () => DropdownButtonFormField<String>(
                  value:
                      controller.selectedProvince.value.isEmpty
                          ? null
                          : controller.selectedProvince.value,
                  items:
                      controller.provinces
                          .map(
                            (p) => DropdownMenuItem(value: p, child: Text(p)),
                          )
                          .toList(),
                  decoration: const InputDecoration(labelText: 'المحافظة'),
                  onChanged: (v) => controller.selectedProvince.value = v ?? '',
                  validator:
                      (v) => v == null || v.isEmpty ? 'اختر المحافظة' : null,
                ),
              ),
              const SizedBox(height: 15),

              // التخصص
              TextFormField(
                controller: controller.specializationController,
                decoration: const InputDecoration(
                  labelText: 'التخصص',
                  hintText: 'أدخل تخصصك هنا',
                ),
                validator:
                    (v) => v == null || v.isEmpty ? 'يرجى إدخال التخصص' : null,
              ),
              const SizedBox(height: 30),

              // زر التعديل
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003366),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: controller.save,
                child: const Text(
                  'تعديل المعلومات',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
