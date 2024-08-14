//File path: lib/models/user.dart
class User {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String countryName;
  final String countryCode;
  final String roles;
  final String identifier;

  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.countryName,
    required this.countryCode,
    required this.roles,
    required this.identifier,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final actor = json['actor'] as Map<String, dynamic>;
    final country = actor['country'] as Map<String, dynamic>;
    final roles = json['roles'] as List<dynamic>;
    return User(
      id: json['id'].toString(),
      lastName: actor['lastName'] as String,
      firstName: actor['firstName'] as String,
      email: json['email'] as String,
      countryName: country['name'] as String,
      countryCode: country['code'] as String,
      roles: roles.isNotEmpty ? roles.first.toString() : 'Unknown',
      identifier: actor['identifier'] as String,
    );
  }
}