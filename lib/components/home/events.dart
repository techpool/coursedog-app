import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:coursedog_app/components/common/event_card.dart';
import 'package:coursedog_app/models/event.dart';
import 'package:coursedog_app/notifiers/event.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    List<Event> upcomingEvents = Provider.of<EventNotifier>(context)
        .events
        .where((event) => !Provider.of<FavouritesNotifier>(context)
            .isEventFavourite(event.id))
        .toList();

    List<Event> subscribedEvents = Provider.of<EventNotifier>(context)
        .events
        .where((event) =>
            Provider.of<FavouritesNotifier>(context).isEventFavourite(event.id))
        .toList();

    final Set upcomingEventIds = <String>{};
    upcomingEvents.retainWhere((event) => upcomingEventIds.add(event.id));

    final Set favouriteEventIds = <String>{};
    subscribedEvents.retainWhere((event) => favouriteEventIds.add(event.id));

    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ButtonsTabBar(
                  radius: 100,
                  backgroundColor: Theme.of(context).primaryColor,
                  unselectedBackgroundColor:
                      Theme.of(context).unselectedWidgetColor,
                  tabs: [
                    Tab(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.notifications,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'Subscribed',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Tab(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.notifications,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'Upcoming',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: subscribedEvents.isEmpty
                        ? const Center(child: Text('No subscribed events'))
                        : ListView(
                            children: subscribedEvents
                                .map((event) => EventCard(event: event))
                                .toList(),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView(
                      children: upcomingEvents
                          .map((event) => EventCard(event: event))
                          .toList(),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
