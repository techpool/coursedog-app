import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            title: const Text('Course Name'),
            subtitle: const Text('Section Number'),
            trailing: const Text('Course Code'),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('DELETE'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
