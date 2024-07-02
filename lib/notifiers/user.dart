import 'package:coursedog_app/utils/api.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  List<String> _schools = <String>[];
  LoadingState _loginState = LoadingState.init;

  List<String> get schools => _schools;
  LoadingState get loginState => _loginState;

  void fetchSchoolsForEmail(String email) async {
    _loginState = LoadingState.loading;
    notifyListeners();
    final response = await login(email);
    _schools = response.schools;
    _loginState = LoadingState.loaded;
    notifyListeners();
  }
}
