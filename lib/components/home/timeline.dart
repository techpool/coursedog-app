import 'package:coursedog_app/components/common/date_section.dart';
import 'package:coursedog_app/modals/subscribe_to_course.dart';
import 'package:coursedog_app/models/meeting.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:coursedog_app/notifiers/meeting.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Meeting>> groupedMeetings =
        Provider.of<MeetingNotifier>(context)
            .meetingsGroupedByStartDateAndFiltered(
                Provider.of<FavouritesNotifier>(context).eventFavourites,
                Provider.of<FavouritesNotifier>(context).courseFavourites);
    bool hasNoFutureMeetings = groupedMeetings.isEmpty;
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          hasNoFutureMeetings
              ? Expanded(
                  child: Center(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.event_busy, size: 100),
                    const SizedBox(height: 16),
                    const Text('No upcoming events, enjoy your day!'),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            openSubscribeToCourse(context);
                          },
                          child: const Text('Subscribe to Event'),
                        ),
                        const Gap(16),
                        ElevatedButton(
                          onPressed: () {
                            openSubscribeToCourse(context);
                          },
                          child: const Text('Subscribe to Course'),
                        )
                      ],
                    )
                  ],
                )))
              : Expanded(
                  child: ListView.builder(
                      itemCount: groupedMeetings.keys.length,
                      itemBuilder: (context, index) {
                        final date = groupedMeetings.keys.elementAt(index);
                        final meetings = groupedMeetings[date] ?? [];
                        return DateSection(date: date, meetings: meetings);
                      }))
        ]));
  }
}
