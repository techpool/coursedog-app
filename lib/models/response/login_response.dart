class LoginResponse {
  final List<String> schools;

  const LoginResponse({required this.schools});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      schools: List<String>.from(json['schools']),
    );
  }
}
