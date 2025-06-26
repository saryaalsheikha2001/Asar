import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'donation_controller.dart';

class DonationAddPage extends StatelessWidget {
  final DonationAddController controller = Get.put(DonationAddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة تبرع")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(controller.nameController, "اسم المتبرع"),
              SizedBox(height: 12),
              _buildTextField(
                controller.phoneController,
                "رقم الهاتف",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller.amountController,
                "المبلغ",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller.transferNumberController,
                "رقم التحويل (اختياري)",
              ),
              SizedBox(height: 12),

              Text("نوع التبرع", style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedType.value,
                  items: [
                    DropdownMenuItem(value: 'حوالة', child: Text('حوالة')),
                    DropdownMenuItem(value: 'كاش', child: Text('كاش')),
                  ],
                  onChanged: (val) {
                    if (val != null) controller.selectedType.value = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "صورة عن الإيصال (اختياري)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child:
                      controller.receiptImage.value == null
                          ? Center(child: Text("اضغط لاختيار صورة"))
                          : Image.file(
                            controller.receiptImage.value!,
                            fit: BoxFit.cover,
                          ),
                ),
              ),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: controller.submitDonation,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue[900],
                ),
                child: Text(
                  "إرسال التبرع",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
