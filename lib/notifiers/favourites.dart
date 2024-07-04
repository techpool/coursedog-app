import 'package:coursedog_app/models/favourite_course.dart';
import 'package:coursedog_app/models/favourite_events.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FavouritesNotifier extends ChangeNotifier {
  List<FavouriteEvent> _eventFavourites = [];
  List<FavouriteCourse> _courseFavourites = [];

  List<FavouriteEvent> get eventFavourites => _eventFavourites;
  List<FavouriteCourse> get courseFavourites => _courseFavourites;

  void addCourseFavourite({
    required String courseId,
    required String sectionId,
  }) async {
    FavouriteCourse? favouriteCourse = await api.addCourseFavourite(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
      courseId: courseId,
      sectionId: sectionId,
      termId: Provider.of<TermNotifier>(Get.context!, listen: false)
          .selectedTerm!
          .id,
    );

    if (favouriteCourse == null) return;

    _courseFavourites.add(favouriteCourse);
    notifyListeners();
  }

  void removeFavourite(String id) async {
    await api.removeCourseFavourite(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
      id,
    );

    _courseFavourites.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void getCourseFavourites() async {
    _courseFavourites = await api.fetchFavouriteCourses(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
    );
    notifyListeners();
  }

  void getEventFavourites() async {
    _eventFavourites = await api.fetchFavouriteEvents(
      Provider.of<UserNotifier>(Get.context!, listen: false).selectedSchool!,
    );
    notifyListeners();
  }
}