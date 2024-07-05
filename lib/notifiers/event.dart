import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EventNotifier extends ChangeNotifier {
  final List<Event> _events = [];
  List<Event> get events => _events;

  void addEvent(Event event) async {
    _events.add(event);
    notifyListeners();
  }

  Future<void> fetchUpcomingEvents() async {
    List<Event>? events = await api.fetchFutureEvents(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
    );
    _events.addAll(events ?? []);

    notifyListeners();
  }
}
