import 'package:coursedog_app/components/common/course_card.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          children: Provider.of<FavouritesNotifier>(context)
              .courseFavourites
              .map((course) => const CourseCard())
              .toList(),
        ));
  }
}
