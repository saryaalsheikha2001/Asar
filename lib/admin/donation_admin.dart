import 'package:athar_project/admin/donation_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationsPage extends StatelessWidget {
  const DonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5FAFF),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff003366),
          title: const Text('أثر', style: TextStyle(color: Colors.white)),
          actions: const [
            Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'التبرعات',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          'الرصيد الكلي :        ${controller.totalAmount}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'جدول التبرعات',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(color: Color(0xffE6F0FA)),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'القيمة',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'اسم المتبرع',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          ...controller.donations.map((donation) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    donation.amount,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    donation.donorName,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
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
  }
}
