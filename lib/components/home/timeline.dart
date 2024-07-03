import 'package:coursedog_app/components/common/term_selector.dart';
import 'package:coursedog_app/modals/subscribe_to_course.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

bool get hasNoFutureMeetings => true;

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const TermSelector(),
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
              : ListView(
                  children: const [],
                )
        ]));
  }
}
