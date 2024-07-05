import 'package:coursedog_app/models/favourite_course.dart';
import 'package:coursedog_app/models/favourite_events.dart';
import 'package:coursedog_app/models/meeting.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeetingNotifier extends ChangeNotifier {
  final List<Meeting> _meetings = [];
  List<Meeting> get meetings => _meetings;

  void addMeeting(Meeting event) async {
    _meetings.add(event);
    notifyListeners();
  }

  Map<DateTime, List<Meeting>> meetingsGroupedByStartDateAndFiltered(
      List<FavouriteEvent> favouriteEvents,
      List<FavouriteCourse> favouriteCourses) {
    Map<DateTime, List<Meeting>> groupedMeetings = {};

    List<Meeting> meetingsWithStartDate = _meetings
        .where((meeting) => meeting.startDate != null)
        .where((meeting) {
      if (meeting.isAcademic) {
        return favouriteCourses.any((element) =>
            element.courseId == meeting.courseId &&
            element.sectionId == meeting.sectionId &&
            element.termId ==
                Provider.of<TermNotifier>(Get.context!, listen: false)
                    .terms
                    .firstWhere((term) =>
                        term.year == meeting.year &&
                        term.semester == meeting.semester)
                    .id);
      } else {
        return favouriteEvents
            .any((element) => element.eventId == meeting.eventId);
      }
    }).toList();

    for (Meeting meeting in meetingsWithStartDate) {
      DateTime startDate = meeting.startDate!;

      if (groupedMeetings[startDate] == null) {
        groupedMeetings[startDate] = [];
      }

      groupedMeetings[startDate]!.add(meeting);
    }

    return groupedMeetings;
  }

  Future<void> fetchUpcomingMeetings() async {
    List<Meeting>? meetings = await api.fetchFutureMeetings(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
    );
    _meetings.addAll(meetings ?? []);

    notifyListeners();
  }
}
