import 'package:athar_project/volunter/tabroat/my_tabroat.dart';
import 'package:athar_project/volunter/tabroat/tabroat_controller.dart';
import 'package:athar_project/volunter/tabroat/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabroat extends StatelessWidget {
  const Tabroat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabroatController>(
      init: TabroatController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xFFF6FAFF), // خلفية الصفحة نفس لون صورتك
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(
              0,
              51,
              102,
              1,
            ), // لون الأزرق الغامق مثل صورتك
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(MyTabroat());
                },
                icon: Row(
                  children: [
                    Icon(Icons.payment, color: Colors.white),
                    Text("تبرعاتي", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
            centerTitle: true,
            title: const Text(
              'التبرعات',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            elevation: 0,
            automaticallyImplyLeading:
                true, // يظهر زر الرجوع بشكل تلقائي إذا فيه رجوع
          ),
          body:
              controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'اسم الفريق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<TeamsData>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                labelText: "اختر الفريق",
                                border: OutlineInputBorder(),
                              ),
                              value: controller.selectedTeam,
                              items:
                                  controller.teamsModel.data!.map((team) {
                                    return DropdownMenuItem<TeamsData>(
                                      value: team,
                                      child: Text(team.teamName ?? ""),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                controller.selectTeam(value);
                              },
                            ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     hintText: 'اسم الفريق',
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     contentPadding: const EdgeInsets.symmetric(
                            //       horizontal: 16,
                            //       vertical: 12,
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'رقم العملية',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller:
                                  controller
                                      .transferNumberTextEditingController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'رقم العملية',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'المبلغ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller:
                                  controller.amountTextEditingController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "هذا الحقل مطلوب";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'المبلغ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'صورة عن الإيصال',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            controller.selectedImage != null
                                ? Image.file(
                                  controller.selectedImage!,
                                  height: 150,
                                )
                                : Text('لا يوجد صورة'),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: controller.pickImage,
                              child: Text('إضغط لإضافة صورة'),
                            ),
                            // Container(
                            //   height: 150,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border: Border.all(color: Colors.grey),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                            const SizedBox(height: 40),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // كود الدفع لاحقاً
                                  await controller.postTabroat();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0A3C6E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'ادفع',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
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
}
