import 'dart:developer';

import 'package:athar_project/admin/login/LoginController_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_admin extends StatelessWidget {
  Login_admin({super.key});

  // final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        init: LoginController(),
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
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Dropdown
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'نوع الحساب',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            value: controller.selectedTeam,
                            items:
                                controller.teams.map((team) {
                                  return DropdownMenuItem<String>(
                                    value: team,
                                    child: Text(team),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              controller.selectedTeam = value!;
                              controller.update();
                            },
                          ),

                          const SizedBox(height: 20),

                          // Email
                          TextFormField(
                            controller: controller.emailTextEditingController,
                            // onChanged: (value) => controller.email = value,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Password
                          TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'كلمة المرور',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // زر تسجيل الدخول
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async => await controller.login(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                backgroundColor: const Color.fromRGBO(
                                  0,
                                  51,
                                  102,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // رابط إنشاء حساب
                          GestureDetector(
                            onTap: () {
                              Get.snackbar(
                                "ملاحظة",
                                "راجع إدارة الفريق",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.grey[200],
                                colorText: Colors.black,
                              );
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: 'لا تملك حساب؟ ',
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: 'إنشاء حساب',
                                    style: TextStyle(
                                      color: Color(0xFF0D47A1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
