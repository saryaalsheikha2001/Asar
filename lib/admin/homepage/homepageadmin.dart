import 'dart:io';

import 'package:athar_project/admin/chat_Admin/CampaignChatPage.dart';
import 'package:athar_project/admin/details_about_hamla.dart';
import 'package:athar_project/admin/homepage/home_page_controller.dart';
import 'package:athar_project/admin/model/CompagineAdmin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

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
              actions: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed("/NotificationsPage");
                      },
                      icon: Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
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
            body: GetBuilder<HomePageController>(
              init: HomePageController(),
              builder: (controller) {
                return controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : TabBarView(
                      children: [
                        //////////////////////////////////////// حملات منتهية //////////////////////////////////////
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          itemCount: controller.campaignsDoneModel.data?.length,
                          itemBuilder: (context, index) {
                            var campaign =
                                controller.campaignsDoneModel.data?[index];
                            return _buildCampaignCard(campaign!);
                          },
                        ),

                        // Obx(() {
                        //   var finished = controller.finishedCampaigns;
                        //   return finished.isEmpty
                        //       ? const Center(child: Text('لا توجد حملات منتهية حاليًا'))
                        //       : ListView.builder(
                        //         padding: const EdgeInsets.symmetric(vertical: 10),
                        //         itemCount: finished.length,
                        //         itemBuilder: (context, index) {
                        //           var campaign = finished[index];
                        //           return _buildCampaignCard(campaign);
                        //         },
                        //       );
                        // }),

                        //////////////////////////////////////// حملات جارية //////////////////////////////////////
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final result = await Get.toNamed(
                                        '/add_hamla',
                                      );
                                      if (result != null &&
                                          result is Map<String, String>) {
                                        controller.addCampaign(result);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
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
                                              controller.searchQuery = value,
                                      decoration: InputDecoration(
                                        hintText: 'بحث عن حملة',
                                        prefixIcon: const Icon(Icons.search),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 16,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.filter_list,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                itemCount:
                                    controller
                                        .campaignsPendingModel
                                        .data
                                        ?.length,
                                itemBuilder: (context, index) {
                                  var campaign =
                                      controller
                                          .campaignsPendingModel
                                          .data?[index];
                                  return _buildCampaignCard(campaign!);
                                },
                              ),
                            ),
                            // Expanded(
                            //   child: Obx(() {
                            //     var filtered = controller.filteredCampaigns;
                            //     return filtered.isEmpty
                            //         ? const Center(
                            //           child: Text('لا توجد حملات مطابقة'),
                            //         )
                            //         : ListView.builder(
                            //           padding: const EdgeInsets.symmetric(
                            //             vertical: 10,
                            //           ),
                            //           itemCount: filtered.length,
                            //           itemBuilder: (context, index) {
                            //             var campaign = filtered[index];
                            //             return GestureDetector(
                            //               onTap: () {
                            //                 Get.to(
                            //                   () => CampaignDetailsPage(
                            //                     campaign: campaign,
                            //                   ),
                            //                 );
                            //               },
                            //               child: _buildCampaignCard(
                            //                 campaign,
                            //                 showChatButton: true,
                            //               ),
                            //             );
                            //           },
                            //         );
                            //   }),
                            // ),
                          ],
                        ),
                      ],
                    );
              },
            ),
          ),
        ),
      ),
    );
  }

  // كرت الحملة (نفسه للمنتهية والجارية، مع خيار زر التواصل)
  Widget _buildCampaignCard(Datum campaign, {bool showChatButton = true}) {
    final imagePath = campaign.team?.logo;
    // final isFile = imagePath!.startsWith('/');

    return InkWell(
      onTap: () {
        Get.to(() => CampaignDetailsPage(campaign: campaign));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الصورة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "http://volunteer.test-holooltech.com/" + imagePath!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
                          width: 60,
                          height: 60,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  // الاسم والتكلفة ونوع الحملة
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // التكلفة
                            Text(
                              "${campaign.cost ?? ''}\$",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // اسم الحملة
                            Expanded(
                              child: Text(
                                campaign.campaignName ?? '',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // نوع الحملة
                        Text(
                          campaign.campaignType?.name ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // التاريخ، عدد المشاركين، زر التواصل
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // التاريخ
                  Text(
                    campaign.from.toString().split(' ').first,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  // عدد المشاركين
                  Text(
                    "${campaign.numberOfVolunteer} مشارك",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  // زر تواصل
                  if (showChatButton)
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          '/CampaignChatPage',
                          arguments: {'campaignName': campaign.campaignName},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                          0,
                          51,
                          102,
                          1,
                        ), // مثل الصورة
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "تواصل",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
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
