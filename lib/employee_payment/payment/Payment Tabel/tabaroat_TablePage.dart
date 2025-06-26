
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/edit_tabaroat_page.dart';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabel_tabaroat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationsTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationTableController>(
      init: DonationTableController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "التبرعات",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "الرصيد الكلي: ${controller.totalBalance} \$",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.donations.length,
                    itemBuilder: (context, index) {
                      final donation = controller.donations[index];
                      return Card(
                        child: ListTile(
                          title: Text(donation.benefactorName),
                          subtitle: Text("${donation.amount} \$"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => EditDonationPage(donation: donation),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "تأكيد الحذف",
                                    middleText: "هل تريد حذف هذا التبرع؟",
                                    textConfirm: "نعم",
                                    textCancel: "إلغاء",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      Get.back();
                                      controller.deleteDonation(donation.id);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
