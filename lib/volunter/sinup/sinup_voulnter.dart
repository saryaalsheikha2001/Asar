import 'package:athar_project/volunter/core/model/specializations_model.dart';
import 'package:athar_project/volunter/sinup/sinup_voulnter_controller.dart';
import 'package:athar_project/volunter/sinup/voulnter_from.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class sinup_voulnter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<sinup_voulnter_controller>(
        init: sinup_voulnter_controller(),
        builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // العنوان
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 51, 102, 1),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'انشاء حساب ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // الاسم الكامل
                            TextFormField(
                              controller: controller.nameController,
                              decoration: const InputDecoration(
                                labelText: "الاسم الكامل",
                                hintText: "من فضلك قم بإدخال اسمك الكامل",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال الاسم الكامل';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // البريد الإلكتروني
                            TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "البريد الإلكتروني",
                                hintText: "Sample@mail.com",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال البريد الإلكتروني';
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return 'يرجى إدخال بريد إلكتروني صحيح';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // كلمة المرور
                            TextFormField(
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordHidden,
                              decoration: InputDecoration(
                                labelText: "كلمة المرور",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                }
                                if (value.length < 8) {
                                  return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            DropdownButtonFormField<SpecializationsModel>(
                              decoration: InputDecoration(
                                labelText: "اختر التخصص",
                              ),
                              value: controller.selectedSpecialization,
                              items:
                                  controller.specializations.map((spec) {
                                    return DropdownMenuItem(
                                      value: spec,
                                      child: Text(spec.name ?? "Unknown"),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                controller.selectedSpecialization = value;
                                controller.update();
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'الرجاء اختيار تخصص';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            // زر إنشاء الحساب
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                  0,
                                  51,
                                  102,
                                  1,
                                ),

                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () async {
                                await controller.register();
                              },

                              // () async => await controller.register(),
                              child: const Text(
                                "إنشاء الحساب",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // رابط تسجيل الدخول
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("لديك حساب؟ "),
                                GestureDetector(
                                  onTap: () {
                                    Get.back(); // يرجع إلى صفحة تسجيل الدخول
                                  },
                                  child: const Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 51, 102, 1),

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
