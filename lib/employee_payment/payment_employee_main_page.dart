import 'package:athar_project/employee_payment/Donation/donation_add_page.dart';
import 'package:athar_project/employee_payment/payment/Payment%20Tabel/tabaroat_TablePage.dart';
import 'package:flutter/material.dart';

class PaymentEmployeeMainPage extends StatelessWidget {
  const PaymentEmployeeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد الواجهات للمشرف
      child: Scaffold(
        appBar: AppBar(
          title: Text("لوحة تحكم المشرف"),
          bottom: TabBar(
            tabs: [Tab(text: "عرض التبرعات"), Tab(text: "إضافة تبرع")],
          ),
        ),
        body: TabBarView(children: [DonationsTablePage(), DonationAddPage()]),
      ),
    );
  }
}
