import 'package:coursedog_app/components/common/event_card.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [EventCard()],
        ));
  }
}
