import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Event Title'),
            subtitle: Text('Event Description'),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: null,
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
