import 'package:athar_project/volunter/shakawa/all_shakawa_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllShakawaPage extends StatelessWidget {
  const AllShakawaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllShakawaController>(
      init: AllShakawaController(), // أو Get.put() مسبقًا
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('الشكاوى'),
            backgroundColor: const Color(0xFF0A3C6E),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.complaints.data!.length,
            itemBuilder: (context, index) {
              final complaint = controller.complaints.data![index];
              final imageUrl =
                  'http://volunteer.test-holooltech.com/${complaint.volunteer?.image}';

              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  complaint.volunteer?.fullName ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  complaint.volunteer?.email ?? "",
                                  style: const TextStyle(fontSize: 13),
                                ),
                                Text(
                                  complaint.volunteer?.phone ?? "",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(complaint.status ?? ""),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _statusText(complaint.status ?? ""),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text("النوع: ${_typeText(complaint.type ?? "")}"),
                      const SizedBox(height: 8),
                      Text(complaint.content ?? ""),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _statusText(String status) {
    switch (status) {
      case 'pending':
        return 'قيد المعالجة';
      case 'accepted':
        return 'تم القبول';
      case 'rejected':
        return 'مرفوضة';
      default:
        return 'غير معروف';
    }
  }

  String _typeText(String type) {
    return type == 'suggestion' ? 'اقتراح' : 'شكوى';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
