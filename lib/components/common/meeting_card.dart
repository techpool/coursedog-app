import 'package:coursedog_app/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  const MeetingCard({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return // Add a card here
        Card(
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(meeting.isAcademic ? 'Academic' : 'Non-academic',
              style: Theme.of(context).textTheme.bodySmall),
        ),
        ListTile(
          onTap: () {},
          title: Text(
              '${meeting.startTimeIn12HrFormat} - ${meeting.endTimeIn12HrFormat}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10.0),
              Row(children: [
                const Icon(Icons.calendar_today, size: 14.0),
                const Gap(10.0),
                Text('Mathematics',
                    style: Theme.of(context).textTheme.bodySmall)
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
      ]),
    );
  }
}
