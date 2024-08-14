class Typebet {
  final int id;
  final String reference;
  final int percentage;
  final String name;

  Typebet({
    required this.id,
    required this.reference,
    required this.percentage,
    required this.name,
  });

  factory Typebet.fromJson(Map<String, dynamic> json) {
    return Typebet(
      id: json['id'] is String ? int.parse(json['id']) : json['id'], // Handle id as string or int
      reference: json['reference'],
      percentage: json['percentage'] is String ? int.parse(json['percentage']) : json['percentage'], // Handle percentage as string or int
      name: json['name'],
    );
  }
}
