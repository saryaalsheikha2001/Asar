import 'dart:io';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabaroat_model.dart';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabel_tabaroat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditDonationPage extends StatefulWidget {
  final Donation donation;
  const EditDonationPage({super.key, required this.donation});

  @override
  State<EditDonationPage> createState() => _EditDonationPageState();
}

class _EditDonationPageState extends State<EditDonationPage> {
  final controller = Get.find<DonationTableController>();
  late TextEditingController amountCtrl;
  late TextEditingController typeCtrl;
  late TextEditingController statusCtrl;
  late TextEditingController dateCtrl;
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController transferCtrl;

  @override
  void initState() {
    amountCtrl = TextEditingController(text: widget.donation.amount);
    typeCtrl = TextEditingController(text: widget.donation.type);
    statusCtrl = TextEditingController(text: widget.donation.status);
    dateCtrl = TextEditingController(text: widget.donation.paymentDate);
    nameCtrl = TextEditingController(text: widget.donation.benefactorName);
    phoneCtrl = TextEditingController(text: widget.donation.benefactorPhone ?? '');
    transferCtrl = TextEditingController(text: widget.donation.transferNumber ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationTableController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("تعديل التبرع")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                _buildField("المبلغ", amountCtrl),
                _buildField("نوع التبرع", typeCtrl),
                _buildField("الحالة", statusCtrl),
                _buildField("تاريخ الدفع (Y-m-d)", dateCtrl),
                _buildField("اسم المتبرع", nameCtrl),
                _buildField("رقم الهاتف", phoneCtrl),
                _buildField("رقم التحويل", transferCtrl),
                const SizedBox(height: 10),
                controller.selectedImage != null
                    ? Image.file(controller.selectedImage!, height: 150)
                    : const SizedBox(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text("اختيار صورة"),
                  onPressed: controller.pickImage,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final updated = Donation(
                      id: widget.donation.id,
                      amount: amountCtrl.text,
                      type: typeCtrl.text,
                      status: statusCtrl.text,
                      paymentDate: dateCtrl.text,
                      benefactorName: nameCtrl.text,
                      benefactorPhone: phoneCtrl.text,
                      transferNumber: transferCtrl.text,
                      image: widget.donation.image,
                    );
                    await controller.updateDonation(updated);
                    Get.back();
                  },
                  child: const Text("حفظ التعديلات"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
