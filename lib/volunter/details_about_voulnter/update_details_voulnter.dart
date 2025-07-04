import 'dart:io';
import 'package:athar_project/volunter/details_about_voulnter/detail_voulnter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class update_detail_voulnter extends StatelessWidget {
  final DetailVoulnterController controller = Get.find();

  update_detail_voulnter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تعديل المعلومات',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003366),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Obx(() {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  controller.avatarPath.value.isNotEmpty
                                      ? FileImage(File(controller.avatarPath.value))
                                      : (controller.profile.value?.image != null
                                          ? NetworkImage(
                                              "http://volunteer.test-holooltech.com${controller.profile.value!.image!.startsWith('/') ? '' : '/'}${controller.profile.value!.image!}",
                                            )
                                          : const AssetImage(
                                              'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
                                            )) as ImageProvider?,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: controller.pickImage,
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Color(0xFF003366),
                                  child: Icon(
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

                      TextFormField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: 'الاسم الكامل',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال الاسم' : null,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'يرجى إدخال البريد';
                          final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailReg.hasMatch(v)) return 'بريد إلكتروني غير صالح';
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'رقم الهاتف',
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'يرجى إدخال رقم الهاتف';
                          if (!RegExp(r'^09\d{8}$').hasMatch(v)) return 'رقم غير صحيح';
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      Obx(() {
                        return DropdownButtonFormField<String>(
                          value: controller.provinces.contains(controller.selectedProvince.value)
                              ? controller.selectedProvince.value
                              : null,
                          items: controller.provinces
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => controller.selectedProvince.value = v ?? '',
                          decoration: const InputDecoration(labelText: 'التخصص'),
                          validator: (v) => v == null || v.isEmpty ? 'يرجى اختيار التخصص' : null,
                        );
                      }),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: controller.nationalNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'الرقم الوطني',
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'يرجى إدخال الرقم الوطني';
                          if (v.length != 11) return 'يجب أن يتكون من 11 رقم';
                          if (!RegExp(r'^\d{11}$').hasMatch(v)) return 'الرقم الوطني غير صالح';
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: controller.birthDateController,
                        readOnly: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.birthDateController.text =
                                pickedDate.toIso8601String().split('T').first;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'تاريخ الميلاد',
                          hintText: 'YYYY-MM-DD',
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'يرجى إدخال تاريخ الميلاد';
                          if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(v)) return 'صيغة التاريخ غير صحيحة';
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      ElevatedButton(
                        onPressed: controller.updateVolunteerProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003366),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        ),
                        child: const Text(
                          'حفظ المعلومات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
