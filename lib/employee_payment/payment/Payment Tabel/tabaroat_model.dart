class Donation {
  final int id;
  final String amount;
  final String type;
  final String status;
  final String paymentDate;
  final String? transferNumber;
  final String? image;
  final String benefactorName;
  final String? benefactorPhone;

  Donation({
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    required this.paymentDate,
    required this.transferNumber,
    required this.image,
    required this.benefactorName,
    required this.benefactorPhone,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      paymentDate: json['payment_date'],
      transferNumber: json['transfer_number'],
      image: json['image'],
      benefactorName: json['benefactor_name'],
      benefactorPhone: json['benefactor_phone'],
    );
  }
}
