import 'package:coursedog_app/models/course.dart';
import 'package:coursedog_app/models/favourite_course.dart';
import 'package:coursedog_app/models/term.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CourseNotifier extends ChangeNotifier {
  final List<Course> _courses = [];
  List<Course> get courses => _courses;

  void addCourse(Course course) async {
    _courses.add(course);
    notifyListeners();
  }

  void fetchFavouriteCourses(List<FavouriteCourse> favouriteCourses) async {
    if (favouriteCourses.isEmpty) return;

    final List<String> courseIds =
        favouriteCourses.map((e) => e.courseId).toList();
    final Term term = Provider.of<TermNotifier>(Get.context!, listen: false)
        .terms
        .firstWhere((e) => e.id == favouriteCourses.first.termId);

    final List<Course> courses = await api.fetchCourses(
      school: Provider.of<UserNotifier>(Get.context!, listen: false)
          .selectedSchool!,
      term: term,
      listOfCourseIds: courseIds,
    );

    _courses.addAll(courses);

    notifyListeners();
  }
}
