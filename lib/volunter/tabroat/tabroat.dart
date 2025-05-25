import 'package:flutter/material.dart';

class Tabroat extends StatelessWidget {
  const Tabroat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FAFF), // خلفية الصفحة نفس لون صورتك
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(
          0,
          51,
          102,
          1,
        ), // لون الأزرق الغامق مثل صورتك
        centerTitle: true,
        title: const Text(
          'التبرعات',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevation: 0,
        automaticallyImplyLeading:
            true, // يظهر زر الرجوع بشكل تلقائي إذا فيه رجوع
      ),
      body: Padding(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'اسم الفريق',
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
                  'رقم العملية',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                  'صورة عن الإيصال',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // كود الدفع لاحقاً
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A3C6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ادفع',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
