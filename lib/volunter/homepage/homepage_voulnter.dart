import 'package:athar_project/volunter/hamla_details/hamla_details_page.dart';
import 'package:athar_project/volunter/homepage/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class homepage_voulnter extends StatelessWidget {
  // final HamlaController controller = Get.put(HamlaController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 51, 102, 1),
          title: Text('آثر', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                _showSearchDialog(context);
              },
            ),
          ],
        ),
        body: GetBuilder<HamlaController>(
          init: HamlaController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: controller.campaignsModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final donation = controller.campaignsModel.data![index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => HamlaDetails(id: donation.id!));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "http://volunteer.test-holooltech.com/" +
                                      donation.team!.logo!,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      donation.campaignName!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${donation.numberOfVolunteer!} عضو',
                                        ),
                                        SizedBox(width: 12),
                                        Icon(
                                          Icons.access_time,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        // SizedBox(width: 4),
                                        // Text(
                                        //   'from : ' +
                                        //       intl.DateFormat(
                                        //         'yyyy-MM-dd kk:mm a',
                                        //       ).format(donation.from!) +
                                        //       '\n' +
                                        //       'to : ' +
                                        //       intl.DateFormat(
                                        //         'yyyy-MM-dd kk:mm a',
                                        //       ).format(donation.to!),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'من : ' +
                                              intl.DateFormat(
                                                'yyyy-MM-dd kk:mm a',
                                              ).format(donation.from!) +
                                              '\n' +
                                              'الى : ' +
                                              intl.DateFormat(
                                                'yyyy-MM-dd kk:mm a',
                                              ).format(donation.to!),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Get.to(
                                              //   () => HamlaDetails(donation: donation),
                                              // );
                                            },
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
                                            child: Text(
                                              'تفاصيل',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
          },
        ),
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
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final HamlaController controller = Get.find();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('بحث عن فريق'),
            content: TextField(
              controller: searchController,
              // onChanged: controller.searchByTeamName,
              decoration: InputDecoration(hintText: 'أدخل اسم الفريق'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // controller.searchByTeamName(searchController.text);
                  Navigator.pop(context);
                },
                child: Text('بحث'),
              ),
            ],
          ),
    );
  }
}
