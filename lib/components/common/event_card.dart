import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(event.name),
            subtitle: Text(event.description ?? ''),
          ),
          ButtonBar(
            children: [
              Provider.of<FavouritesNotifier>(context)
                      .isEventFavourite(event.id)
                  ? TextButton(
                      onPressed: () {
                        Provider.of<FavouritesNotifier>(context, listen: false)
                            .removeFavourite(Provider.of<FavouritesNotifier>(
                                    context,
                                    listen: false)
                                .eventFavourites
                                .firstWhere(
                                    (element) => element.eventId == event.id)
                                .id);
                      },
                      child: Text('Unsubscribe'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Provider.of<FavouritesNotifier>(context, listen: false)
                            .addEventFavourite(event.id);
                      },
                      child: Text('Subscribe'),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
