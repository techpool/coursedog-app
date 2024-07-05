import 'package:coursedog_app/components/common/top_bar.dart';
import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/notifiers/event.dart';
import 'package:flutter/material.dart';
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
                    Text('Notices:'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
