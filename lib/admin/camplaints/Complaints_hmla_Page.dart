import 'package:athar_project/admin/camplaints/Complaints_hmla_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintsController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5FAFF),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
          title: const Text('آثر', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<ComplaintsController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الشكاوى المقدمة',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: controller.complaints.isEmpty
                        ? const Center(child: Text('لا توجد شكاوى'))
                        : ListView.builder(
                            itemCount: controller.complaints.length,
                            itemBuilder: (context, index) {
                              final item = controller.complaints[index];
                              final isComplaint = item.type == 'شكوى';
                              return GestureDetector(
                                onTap: () => controller.goToComplaintDetails(item),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.type ?? '',
                                              style: TextStyle(
                                                color: isComplaint
                                                    ? Colors.red
                                                    : Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(item.volunteer?.fullName ?? ''),
                                                const SizedBox(width: 8),
                                                const CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: AssetImage(
                                                    "assets/images/photo_2025-04-16_14-38-02-removebg-preview.png",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item.content ?? '',
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                0,
                                                51,
                                                102,
                                                1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () =>
                                                controller.deleteComplaint(item.id!),
                                            child: const Text(
                                              'حذف',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.deleteAll(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff003366),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'حذف الكل',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}