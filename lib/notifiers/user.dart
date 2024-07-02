import 'package:coursedog_app/utils/api.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  List<String> _schools = <String>[];
  LoadingState _loginState = LoadingState.init;
  String _email = '';
  String? _selectedSchool;

  List<String> get schools => _schools;
  LoadingState get loginState => _loginState;
  String get email => _email;
  String? get selectedSchool => _selectedSchool;

  void fetchSchoolsForEmail(String email) async {
    _email = email;
    _loginState = LoadingState.loading;
    notifyListeners();
    final response = await login(email);
    _schools = response.schools;
    _loginState = LoadingState.loaded;

    if (_schools.length == 1) {
      _selectedSchool = _schools.first;
    }
    notifyListeners();
  }

  void resendMagicLink() async {
    _loginState = LoadingState.loading;
    notifyListeners();
    final response = await login(_email);
    _schools = response.schools;
    _loginState = LoadingState.loaded;
    notifyListeners();
  }
}
