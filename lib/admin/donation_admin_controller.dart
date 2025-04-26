import 'package:athar_project/admin/donation_admin_model.dart';
import 'package:get/get.dart';

class DonationController extends GetxController {
  var donations =
      <Donation>[
        Donation(donorName: 'احمد محمد', amount: '500\$'),
        Donation(donorName: 'احمد محمد', amount: '300\$'),
        Donation(donorName: 'احمد محمد', amount: '100\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
        Donation(donorName: 'احمد محمد', amount: '0\$'),
      ].obs;

  String get totalAmount {
    int total = donations.fold(
      0,
      (sum, item) => sum + int.parse(item.amount.replaceAll('\$', '')),
    );
    return '$total\$';
  }
}
