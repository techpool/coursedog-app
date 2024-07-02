import 'dart:convert';

import 'package:coursedog_app/models/response/login_response.dart';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://localhost:9292';

Future<LoginResponse> login(String email) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/v1/general/mobile-login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email}),
  );

  if (response.statusCode == 200) {
    final loginReponse = LoginResponse.fromJson(jsonDecode(response.body));
    return loginReponse;
  } else {
    throw Exception('Failed to login');
  }
}
