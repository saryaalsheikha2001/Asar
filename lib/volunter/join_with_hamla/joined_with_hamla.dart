import 'package:athar_project/volunter/hamla_details/hamla_details_page.dart';
import 'package:athar_project/volunter/join_with_hamla/joined_with_hamla_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homepage/home_page_controller.dart';

class JoinedCampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'الحملات المشترك فيها',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(0, 51, 102, 1),
        ),
        body: GetBuilder<JoinedCampaignController>(
          init: JoinedCampaignController(),
          builder: (controller) {
            return controller.joinedCampaigns.isEmpty
                ? Center(child: Text('لا يوجد حملات مشترك فيها بعد.'))
                : ListView.builder(
                  itemCount: controller.joinedCampaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = controller.joinedCampaigns[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              campaign.team!.logo != null
                                  ? NetworkImage(campaign.team!.logo!)
                                  : AssetImage('assets/default_image.png')
                                      as ImageProvider,
                        ),
                        title: Text(campaign.campaignName ?? ''),
                        subtitle: Text(campaign.team!.teamName ?? ''),
                        onTap: () {
                          if (campaign.id != null) {
                            Get.to(
                              () => HamlaDetails(
                                id: campaign.id!,
                                showChatButton: true,
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
            ;
          },
        ),
      ),
    );
  }
}
