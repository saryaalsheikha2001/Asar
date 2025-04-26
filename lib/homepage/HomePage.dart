import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 40),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 51, 102, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    'أهلاً بك في',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'آثر',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  accountOption(
                    icon: Icons.person,
                    label: "موظف",
                    // onTap: () {
                    //   // استبدل لاحقاً بـ:
                    //   //  Get.toNamed("/admin");
                    //   // Get.snackbar("الموظف", "تم اختيار حساب الموظف");

                    // },
                    onTap: () => Get.toNamed("/Login_admin"),
                  ),
                  const SizedBox(height: 16),
                  accountOption(
                    icon: Icons.person_outline,
                    label: "متطوع",
                    // onTap: () {
                    //   // استبدل لاحقاً بـ:
                    //   Get.toNamed("/volunteer");
                    //   Get.snackbar("المتطوع", "تم اختيار حساب المتطوع");
                    // },
                    onTap: () => Get.toNamed("/Login_voulnter"),
                    // onTap: () => Get.toNamed("/Login_admin"), // الانتقال الصحيح لتسجيل الدخول
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.grey[700]),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
