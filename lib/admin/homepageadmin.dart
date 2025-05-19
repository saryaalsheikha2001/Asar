import 'dart:io';

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
              title: const Text(
                'آثر',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Colors.amber,
                tabs: [Tab(text: 'منتهية'), Tab(text: 'جارية')],
              ),
            ),
            body: TabBarView(
              children: [
                //////////////////////////////////////// حملات منتهية //////////////////////////////////////
                Obx(() {
                  var finished = controller.finishedCampaigns;
                  return finished.isEmpty
                      ? const Center(child: Text('لا توجد حملات منتهية حاليًا'))
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: finished.length,
                        itemBuilder: (context, index) {
                          var campaign = finished[index];
                          return _buildCampaignCard(campaign);
                        },
                      );
                }),

                //////////////////////////////////////// حملات جارية //////////////////////////////////////
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
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
                            label: const Text('إنشاء حملة'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(
                                0,
                                51,
                                102,
                                1,
                              ),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged:
                                  (value) =>
                                      controller.searchQuery.value = value,
                              decoration: InputDecoration(
                                hintText: 'بحث عن حملة',
                                prefixIcon: const Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: const Icon(Icons.filter_list),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        var filtered = controller.filteredCampaigns;
                        return filtered.isEmpty
                            ? const Center(child: Text('لا توجد حملات مطابقة'))
                            : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                var campaign = filtered[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => CampaignDetailsPage(
                                        campaign: campaign,
                                      ),
                                    );
                                  },
                                  child: _buildCampaignCard(
                                    campaign,
                                    showChatButton: true,
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
      ),
    );
  }

  // كرت الحملة (نفسه للمنتهية والجارية، مع خيار زر التواصل)
  Widget _buildCampaignCard(
    Map<String, String> campaign, {
    bool showChatButton = false,
  }) {
    final imagePath = campaign['image']!;
    final isFile = imagePath.startsWith('/');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      isFile
                          ? Image.file(
                            File(imagePath),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                          : Image.asset(
                            imagePath,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        campaign['name'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        campaign['type'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        campaign['participants'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign['amount'] ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      campaign['date'] ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            if (showChatButton) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        '/CampaignChatPage',
                        arguments: {'campaignName': campaign['name']},
                      );
                    },
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: const Text("تواصل"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 51, 102, 1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
