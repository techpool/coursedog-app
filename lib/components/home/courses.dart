import 'package:coursedog_app/components/common/course_card.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            CourseCard(),
            CourseCard(),
            CourseCard(),
          ],
        ));
  }
}
