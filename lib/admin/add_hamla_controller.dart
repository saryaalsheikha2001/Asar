class Campaign {
  final String name;
  final int volunteersNeeded;
  final double cost;
  final String location;
  final String startDate;
  final int points;
  final String teamName;
  final String? teamImagePath; 

  Campaign({
    required this.name,
    required this.volunteersNeeded,
    required this.cost,
    required this.location,
    required this.startDate,
    required this.points,
    required this.teamName,
    this.teamImagePath,
  });
}
