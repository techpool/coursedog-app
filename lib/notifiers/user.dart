import 'package:coursedog_app/models/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserNotifier extends ChangeNotifier {
  List<String> _schools = <String>[];
  LoadingState _loginState = LoadingState.init;
  LoadingState _magicCodeState = LoadingState.init;
  String _email = '';
  String? _selectedSchool;
  User? _user;

  List<String> get schools => _schools;
  LoadingState get loginState => _loginState;
  LoadingState get magicCodeState => _magicCodeState;
  String get email => _email;
  String? get selectedSchool => _selectedSchool;
  User? get user => _user;

  UserNotifier(User? user) {
    _user = user;
    _schools = user?.schools ?? <String>[];
    _email = user?.email ?? '';
    _selectedSchool = user?.schools.first;

    if (user != null) {
      verifyMagicCode(user.magicCode).then((isLoggedIn) {
        if (!isLoggedIn) {
          Get.offAllNamed('/login');
        }
        notifyListeners();
      });
    }
  }

  Future<List<String>> fetchSchoolsForEmail(String email) async {
    _email = email;
    _loginState = LoadingState.loading;
    notifyListeners();
    try {
      final response = await api.login(email);
      _schools = response.schools;
      _loginState = LoadingState.loaded;

      _selectedSchool = _schools.first;
    } catch (e) {
      _loginState = LoadingState.error;
    }
    notifyListeners();
    return _schools;
  }

  Future<List<String>> resendMagicLink() async {
    _loginState = LoadingState.loading;
    notifyListeners();
    final response = await api.login(_email);
    _schools = response.schools;
    _loginState = LoadingState.loaded;
    notifyListeners();
    return _schools;
  }

  Future<bool> verifyMagicCode(String code) async {
    try {
      _magicCodeState = LoadingState.loading;
      notifyListeners();
      _user = await api.verifyMagicCode(_email, code);
      _magicCodeState = LoadingState.loaded;
      GetStorage().write(userKey, _user!.toJson());
    } catch (e) {
      _magicCodeState = LoadingState.error;
    }
    notifyListeners();
    return _magicCodeState == LoadingState.loaded;
  }

  void logout() {
    _user = null;
    GetStorage().remove(userKey);
    Get.offAllNamed('/login');
  }
}
