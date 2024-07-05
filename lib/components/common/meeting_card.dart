import 'package:coursedog_app/models/course.dart';
import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/models/meeting.dart';
import 'package:coursedog_app/notifiers/course.dart';
import 'package:coursedog_app/notifiers/event.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final Event? event;
  final Course? course;
  const MeetingCard(
      {super.key, required this.meeting, this.event, this.course});

  @override
  Widget build(BuildContext context) {
    Course? localCourse;
    if (meeting.isAcademic && course == null) {
      localCourse = Provider.of<CourseNotifier>(context)
          .courses
          .firstWhere((element) => element.id == meeting.courseId);
    }

    Event? localEvent;
    if (!meeting.isAcademic && event == null) {
      localEvent = Provider.of<EventNotifier>(context)
          .events
          .firstWhere((element) => element.id == meeting.eventId);
    }

    return // Add a card here
        Card(
      child: Wrap(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: meeting.isAcademic
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(meeting.isAcademic ? 'Academic' : 'Non-academic',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: meeting.isAcademic
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondary)),
              ),
            )
          ],
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
                Text(
                    (meeting.isAcademic
                            ? course?.name ?? localCourse?.name
                            : event?.name ?? localEvent?.name) ??
                        '',
                    style: Theme.of(context).textTheme.bodySmall)
              ]),
              const Gap(5.0),
              if (meeting.roomId != null)
                Row(children: [
                  const Icon(Icons.location_on, size: 14.0),
                  const Gap(10.0),
                  Text(meeting.roomId!,
                      style: Theme.of(context).textTheme.bodySmall)
                ]),
            ],
          ),
        ),
      ]),
    );
  }
}
