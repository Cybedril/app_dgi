class Obligation {
  final int id;
  final String name;
  final String description;
  final String type;

  Obligation({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  factory Obligation.fromJson(Map<String, dynamic> json) {
    return Obligation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
    );
  }
}
