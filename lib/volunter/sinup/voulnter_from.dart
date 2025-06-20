import 'package:athar_project/volunter/homepage/homepage_voulnter.dart';
import 'package:athar_project/volunter/sinup/voulnter_from_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VolunteerFormScreen extends StatelessWidget {
  const VolunteerFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VolunteerFormController>(
      init: VolunteerFormController(),
      builder:
          (controller) => Scaffold(
            appBar: AppBar(
              title: const Text(
                "استمارة المتطوع",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color.fromRGBO(0, 51, 102, 1),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: controller.pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            controller.profileImage != null
                                ? FileImage(controller.profileImage!)
                                : controller.profileImageUrl != null
                                ? NetworkImage(controller.profileImageUrl!)
                                    as ImageProvider
                                : null,
                        child:
                            controller.profileImage == null &&
                                    controller.profileImageUrl == null
                                ? Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey[700],
                                )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildField(
                    "الرقم الوطني",
                    controller.nationalIdController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildField(
                    "الجنسية",
                    controller.nationalityController,
                    keyboardType: TextInputType.text,
                  ),
                  _buildField(
                    "رقم الموبايل",
                    controller.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildDateField(context, controller),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.validateFormWithMessages()) {
                          // Get.snackbar("تم", "تم التحقق من البيانات بنجاح");
                          await controller.updateProfile();
                          // Get.to(homepage_voulnter());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 51, 102, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "إرسال",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    VolunteerFormController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => controller.pickBirthDate(context),
        child: AbsorbPointer(
          child: _buildField("تاريخ الميلاد", controller.birthDateController),
        ),
      ),
    );
  }
}
