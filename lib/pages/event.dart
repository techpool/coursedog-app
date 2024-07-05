import 'package:coursedog_app/components/common/meeting_card.dart';
import 'package:coursedog_app/components/common/top_bar.dart';
import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/notifiers/event.dart';
import 'package:coursedog_app/notifiers/meeting.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    Event? event = Provider.of<EventNotifier>(context)
        .events
        .firstWhereOrNull((element) => element.id == Get.arguments);

    if (event == null) {
      return const Scaffold(
        body: Center(
          child: Text('Event not found'),
        ),
      );
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: TopBar(
              title: event.name,
              hideBackButton: false,
            )),
        body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    Text(event.description ?? ''),
                    const Divider(),
                    Text('Notices',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    const Text('No notices yet'),
                    // TRY THIS: Add a ListView.builder to display the event notices
                    const Divider(),
                    Text('Type',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    Text(event.type),
                    const Divider(),
                    Text('Start Date',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    Text(event.startDate?.toIso8601String().split('T').first ??
                        ''),
                    const Divider(),
                    Text('End Date',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    Text(event.endDate?.toIso8601String().split('T').first ??
                        ''),
                    const Divider(),
                    Text('Upcoming Meetings',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Gap(10),
                    // TRY THIS: Add a ListView.builder to display the event meetings
                    Expanded(
                      child: ListView.builder(
                          itemCount: Provider.of<MeetingNotifier>(context)
                              .meetings
                              .where((element) => element.eventId == event.id)
                              .length,
                          itemBuilder: (context, index) {
                            return MeetingCard(
                                event: event,
                                meeting: Provider.of<MeetingNotifier>(context)
                                    .meetings
                                    .where((element) =>
                                        element.eventId == event.id)
                                    .elementAt(index));
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
