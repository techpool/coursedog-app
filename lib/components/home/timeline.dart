import 'package:coursedog_app/components/common/date_section.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [DateSection(), DateSection()],
        ));
  }
}
