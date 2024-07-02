import 'package:coursedog_app/components/common/meeting_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

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
            child: Text('Monday, 12th July 2021',
                style: Theme.of(context).textTheme.labelSmall)),

        const Gap(10.0), // Add this line
        const MeetingCard(),
        const MeetingCard(),
        const MeetingCard(),
        const Gap(20.0), // Add this line
      ],
    );
  }
}
