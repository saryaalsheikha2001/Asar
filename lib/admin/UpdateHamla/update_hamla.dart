import 'dart:io';
import 'package:athar_project/admin/AddHamla/add_hamla_controller.dart';
import 'package:athar_project/admin/UpdateHamla/update_hamla_controller.dart';
import 'package:athar_project/admin/model/CompagineAdmin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateHamlaPage extends StatelessWidget {
  Datum campaign;
  UpdateHamlaPage(this.campaign, {Key? key}) : super(key: key);

  // final campaignController = Get.put(UpdateCampaignController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateCampaignController>(
      init: UpdateCampaignController(campaign),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "تعديل حملة",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
            ),
            body:
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            // imagePicker(),
                            customTextField(
                              controller.nameController,
                              'اسم الحملة',
                            ),
                            customTextField(
                              controller.locationController,
                              'مكان الحملة',
                            ),
                            customTextField(
                              controller.costController,
                              'تكلفة الحملة',
                              type: TextInputType.number,
                            ),
                            customTextField(
                              controller.volunteersController,
                              'عدد المتطوعين',
                              type: TextInputType.number,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: GestureDetector(
                                onTap:
                                    () => controller.pickDateTime(
                                      context,
                                      controller.dateController,
                                    ),
                                child: AbsorbPointer(
                                  child: customTextField(
                                    controller.dateController,
                                    'تاريخ الانطلاق',
                                    type: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: GestureDetector(
                                onTap:
                                    () => controller.pickDateTime(
                                      context,
                                      controller.toController,
                                    ),
                                child: AbsorbPointer(
                                  child: customTextField(
                                    controller.toController,
                                    'تاريخ الانتهاء',
                                    type: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ),
                            // customTextField(
                            //   dateController,
                            //   'تاريخ الانطلاق (مثال: 2025-06-30)',
                            //   type: TextInputType.datetime,
                            // ),
                            // customTextField(
                            //   toController,
                            //   'تاريخ الانتهاء (مثال: 2025-06-30)',
                            //   type: TextInputType.datetime,
                            // ),
                            customTextField(
                              controller.pointsController,
                              'عدد النقاط',
                              type: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed:
                                  () async => await controller.submitForm(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                  0,
                                  51,
                                  102,
                                  1,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'تعديل الحملة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }

  Widget customTextField(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
