import 'package:flutter/material.dart';

class JoinedCampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // لاحقًا يتم جلب الحملات المشترك فيها من GetX Controller
    final joinedCampaign = {
      'name': 'حملة تنظيف حديقة تشرين',
      'location': 'دمشق',
      'date': '2025-04-25',
      'image': 'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
    };

    return Scaffold(
      appBar: AppBar(title: Text('الحملة المشترك فيها')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(joinedCampaign['image']!),
            ),
            title: Text(joinedCampaign['name']!),
            subtitle: Text(
              '${joinedCampaign['location']} - ${joinedCampaign['date']}',
            ),
          ),
        ),
      ),
    );
  }
}
