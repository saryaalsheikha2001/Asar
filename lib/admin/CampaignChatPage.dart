import 'package:flutter/material.dart';

class CampaignChatPage extends StatelessWidget {
  final String campaignName;

  const CampaignChatPage({Key? key, required this.campaignName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محادثة - $campaignName'),
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
      ),
      body: const Center(
        child: Text('هنا ستكون المحادثة بين المشرف والمشاركين'),
      ),
    );
  }
}
