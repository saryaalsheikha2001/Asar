import 'package:athar_project/admin/CampaignChatPage.dart';
import 'package:athar_project/admin/details_about_hamla.dart';
import 'package:athar_project/admin/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepageadmin extends StatelessWidget {
  const Homepageadmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
            title: const Text(
              'آثر',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            bottom: const TabBar(
              labelColor: Colors.white,
              tabs: [Tab(text: 'منتهية'), Tab(text: 'جارية')],
            ),
          ),
          body: TabBarView(
            children: [
              ////////////////////////////////////////////////////////////  // حملات منتهية/////////////////////////////////////////////////
              Obx(() {
                var finished = controller.finishedCampaigns;
                return finished.isEmpty
                    ? const Center(child: Text('لا توجد حملات منتهية حاليًا'))
                    : ListView.builder(
                      itemCount: finished.length,
                      itemBuilder: (context, index) {
                        var campaign = finished[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    campaign['image']!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        campaign['name']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(campaign['type']!),
                                      Text(
                                        campaign['participants']!,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      campaign['amount']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      campaign['date']!,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
              }),

              //////////////////////////////////////////////////// حملات جارية //////////////////////////////////
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Get.toNamed('/add_hamla');
                            if (result != null &&
                                result is Map<String, String>) {
                              controller.addCampaign(result);
                            }
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'إنشاء حملة',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              0,
                              51,
                              102,
                              1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged:
                                (value) => controller.searchQuery.value = value,
                            decoration: InputDecoration(
                              hintText: 'بحث عن حملة',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///////////////////////////////////////// قائمة الحملات الجارية//////////////////////////////////////////
                  Expanded(
                    child: Obx(() {
                      var filtered = controller.filteredCampaigns;
                      return filtered.isEmpty
                          ? const Center(child: Text('لا توجد حملات مطابقة'))
                          : ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              var campaign = filtered[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () =>
                                        CampaignDetailsPage(campaign: campaign),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                campaign['image']!,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    campaign['name']!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(campaign['type']!),
                                                  Text(
                                                    campaign['participants']!,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  campaign['amount']!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  campaign['date']!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                // Get.to(() =>
                                                //     CampaignChatPage(
                                                //         campaignName: campaign['name']));
                                                Get.toNamed(
                                                  '/CampaignChatPage',
                                                  arguments: {
                                                    'campaignName':
                                                        campaign['name'],
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.chat),
                                              label: const Text("تواصل"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue[900],
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
