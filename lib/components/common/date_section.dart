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
        Row(children: <Widget>[
          Text(date.toString().split(' ')[0],
              style: Theme.of(context).textTheme.labelMedium),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Theme.of(context).colorScheme.primary,
                  height: 36,
                )),
          ),
        ]),
        const Gap(10.0), // Add this line
        ...meetings.map((meeting) => MeetingCard(meeting: meeting)),
        const Gap(20.0), // Add this line
      ],
    );
  }
}
