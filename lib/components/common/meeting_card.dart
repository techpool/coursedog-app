import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return // Add a card here
        Card(
      child: ListTile(
        onTap: () {},
        title: const Text('9:00 AM - 10:00 AM'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10.0),
            Row(children: [
              const Icon(Icons.calendar_today, size: 14.0),
              const Gap(10.0),
              Text('Mathematics', style: Theme.of(context).textTheme.bodySmall)
            ]),
            const Gap(5.0),
            Row(children: [
              const Icon(Icons.location_on, size: 14.0),
              const Gap(10.0),
              Text('Room 101', style: Theme.of(context).textTheme.bodySmall)
            ]),
            const Gap(5.0),
            Row(children: [
              const Icon(Icons.person, size: 14.0),
              const Gap(10.0),
              Text('John Doe', style: Theme.of(context).textTheme.bodySmall)
            ]),
          ],
        ),
      ),
    );
  }
}
