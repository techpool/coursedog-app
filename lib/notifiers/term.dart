import 'package:coursedog_app/models/term.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermNotifier extends ChangeNotifier {
  List<Term> _terms = <Term>[];
  String? _selectedTermId;
  LoadingState _termLoadingState = LoadingState.init;

  List<Term> get terms => _terms;
  LoadingState get termLoadingState => _termLoadingState;
  String? get selectedTermId => _selectedTermId;
  Term? get selectedTerm =>
      _terms.firstWhereOrNull((term) => term.id == _selectedTermId);

  fetchTerms(String school) async {
    _termLoadingState = LoadingState.loading;
    notifyListeners();
    final response = await api.fetchTerms(school);
    _terms = response ?? <Term>[];
    _termLoadingState = LoadingState.loaded;
    notifyListeners();
  }

  fetchCurrentTerm(String school) async {
    _termLoadingState = LoadingState.loading;
    notifyListeners();
    try {
      final response = await api.fetchCurrentPlanningTerm(school);
      _selectedTermId = response?.id;
      _termLoadingState = LoadingState.loaded;
    } catch (e) {
      _termLoadingState = LoadingState.error;
    }
    notifyListeners();
  }
}
