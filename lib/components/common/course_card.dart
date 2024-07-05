import 'package:coursedog_app/models/course.dart';
import 'package:coursedog_app/models/favourite_course.dart';
import 'package:coursedog_app/models/section.dart';
import 'package:coursedog_app/notifiers/course.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final FavouriteCourse courseFavourite;
  const CourseCard(this.courseFavourite, {super.key});

  @override
  Widget build(BuildContext context) {
    Course? course = Provider.of<CourseNotifier>(context)
        .courses
        .firstWhereOrNull((element) => element.id == courseFavourite.courseId);

    Section? section = course?.sections
        .firstWhereOrNull((element) => element.id == courseFavourite.sectionId);

    if (course == null) {
      return const SizedBox();
    }

    if (section == null) {
      return const SizedBox();
    }

    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            title: Text(course.name),
            subtitle: Text(section.sectionName),
            trailing: Text(course.courseNumber),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  Provider.of<FavouritesNotifier>(context, listen: false)
                      .removeFavourite(courseFavourite.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
