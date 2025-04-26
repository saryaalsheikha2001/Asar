import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_page_controller.dart';

class hamla_details extends StatefulWidget {
  final Hamla donation;

  const hamla_details({required this.donation, required hamla});

  @override
  State<hamla_details> createState() => _HamlaDetailsState();
}

class _HamlaDetailsState extends State<hamla_details> {
  bool isJoined = false; // المستخدم لم ينضم بعد

  void _joinCampaign() {
    setState(() {
      isJoined = true;
    });
    Get.snackbar(
      'تم الانضمام',
      'لقد انضممت إلى الحملة بنجاح',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hamla = widget.donation;

    return Scaffold(
      appBar: AppBar(
        title: Text(hamla.teamName, style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(0, 51, 102, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/images/photo_2025-04-16_14-38-02-removebg-preview.png',
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 95,
              height: 50,
              child: Center(
                child: Text(
                  'اسم الحملة: ${hamla.teamName}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              width: 95,
              height: 50,
              child: Center(
                child: Text(
                  'مدير الحملة: ${hamla.managerName}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 95,
              child: Center(
                child: Text(
                  'عدد الأعضاء: ${hamla.membersCount}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              height: 75,
              width: 95,
              child: Center(
                child: Text('الموقع: دمشق', textAlign: TextAlign.right),
              ),
            ),
            Container(
              height: 50,
              width: 95,
              child: Center(
                child: Text(
                  'المعدات اللازمة: ${hamla.equipment}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 95,
              child: Center(
                child: Text(
                  'وقت الحملة: ${hamla.time}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(height: 20),

            // زر الانضمام
            ElevatedButton.icon(
              onPressed: isJoined ? null : _joinCampaign,
              icon: Icon(Icons.how_to_reg, color: Colors.white),
              label: Text(
                isJoined ? 'تم الانضمام' : 'انضم إلى الحملة',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isJoined ? Colors.grey : Color.fromRGBO(0, 51, 102, 1),
              ),
            ),

            SizedBox(height: 16),

            // زر المحادثة (حاليًا غير مفعل)
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.chat),
              label: Text('محادثة', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
