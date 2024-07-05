import 'package:coursedog_app/components/common/meeting_card.dart';
import 'package:coursedog_app/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DateSection extends StatelessWidget {
  final DateTime date;
  final List<Meeting> meetings;
  const DateSection({super.key, required this.date, required this.meetings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 4.0))),
            child: Text(date.toString().split(' ')[0],
                style: Theme.of(context).textTheme.labelSmall)),
        const Gap(10.0), // Add this line
        ...meetings.map((meeting) => MeetingCard(meeting: meeting)),
        const Gap(20.0), // Add this line
      ],
    );
  }
}
