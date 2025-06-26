import 'package:athar_project/volunter/tabroat/tabroat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabroat extends StatelessWidget {
  const MyTabroat({Key? key}) : super(key: key);

  final String baseUrl = "http://volunteer.test-holooltech.com/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تبرعاتي")),
      body: GetBuilder<TabroatController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.tabroatModel.data!.length,
            itemBuilder: (context, index) {
              final donation = controller.tabroatModel.data![index];
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // فريق
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  baseUrl + (donation.team?.logo ?? ""),
                                ),
                                radius: 25,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    donation.team?.teamName ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "بواسطة: ${donation.team?.fullName ?? ""}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // صورة الحوالة
                          Image.network(
                            baseUrl + (donation.image ?? ""),
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),

                          // تفاصيل التبرع
                          Text("المبلغ: ${donation.amount}"),
                          Text("التاريخ: ${donation.paymentDate}"),
                          Text("النوع: ${donation.type}"),
                          Text("رقم التحويل: ${donation.transferNumber}"),
                          Text(
                            "الحالة: ${donation.status}",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {
                            await controller.deleteTabroatById(donation.id!);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
