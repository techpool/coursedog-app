class User {
  final List<String> schools;
  final String email;
  final String magicCode;
  final String? firstName;
  final String? lastName;

  const User(
      {required this.schools,
      required this.email,
      required this.magicCode,
      required this.firstName,
      this.lastName = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      schools: List<String>.from(json['schools']),
      email: json['email'],
      magicCode: json['magicCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
