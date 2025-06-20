class Employee {
  int id;
  String fullName;
  String email;
  String nationalNumber;
  String position;
  String phone;
  String address;
  String dateAccession;
  String image;
  int teamId;
  int specializationId;

  Employee({
    required this.id,
    required this.fullName,
    required this.email,
    required this.nationalNumber,
    required this.position,
    required this.phone,
    required this.address,
    required this.dateAccession,
    required this.image,
    required this.teamId,
    required this.specializationId, required specialization, required team,
  });
}