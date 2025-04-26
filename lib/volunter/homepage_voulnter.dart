import 'package:athar_project/volunter/hamla_details/hamla_details_page.dart';
import 'package:athar_project/volunter/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homepage_voulnter extends StatelessWidget {
  final HamlaController controller = Get.put(HamlaController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 51, 102, 1),
        title: Text('Asar', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: controller.filteredDonations.length,
          itemBuilder: (context, index) {
            final donation = controller.filteredDonations[index];
            return InkWell(
              onTap: () {
                Get.to(() => hamla_details(donation: donation, hamla: null));
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'دمشق',
                        style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  donation.teamName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(donation.image),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('نوع الحملة ', textAlign: TextAlign.right),
                            SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => hamla_details(
                                      donation: donation,
                                      hamla: null,
                                    ),
                                  );
                                },
                                child: Text('التفاصيل'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   onTap: (index) {
      //     // الانتقال حسب الحاجة
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      //   ],
      // ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('بحث عن فريق'),
            content: TextField(
              controller: searchController,
              onChanged: controller.searchByTeamName,
              decoration: InputDecoration(hintText: 'أدخل اسم الفريق'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.searchByTeamName(searchController.text);
                  Navigator.pop(context);
                },
                child: Text('بحث'),
              ),
            ],
          ),
    );
  }
}
