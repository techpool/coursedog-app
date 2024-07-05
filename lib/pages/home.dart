import 'package:coursedog_app/components/common/top_bar.dart';
import 'package:coursedog_app/components/home/courses.dart';
import 'package:coursedog_app/components/home/events.dart';
import 'package:coursedog_app/components/home/timeline.dart';
import 'package:coursedog_app/modals/subscribe_to_course.dart';
import 'package:coursedog_app/notifiers/course.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _pageViewController = PageController(initialPage: 0);

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _currentIndex = index;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      final termNotifier = Provider.of<TermNotifier>(context, listen: false);
      final favouritesNotifier =
          Provider.of<FavouritesNotifier>(context, listen: false);
      final courseNotifier =
          Provider.of<CourseNotifier>(context, listen: false);

      await Future.wait([
        termNotifier.fetchCurrentTerm(userNotifier.selectedSchool!),
        termNotifier.fetchTerms(userNotifier.selectedSchool!),
        favouritesNotifier.getEventFavourites(),
        favouritesNotifier.getCourseFavourites(),
      ]);

      courseNotifier.fetchFavouriteCourses(favouritesNotifier.courseFavourites);
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentIndex == 1 || _currentIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                if (_currentIndex == 1) {
                  openSubscribeToCourse(context);
                } else {
                  // Open add event modal
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: TopBar(
            title: ['Timeline', 'Courses', 'Events'][_currentIndex],
            hideBackButton: true,
          )),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const <Widget>[
          Icon(Icons.timeline, size: 30),
          Icon(Icons.book, size: 30),
          Icon(Icons.event, size: 30),
        ],
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut);
        },
      ),
      body: PageView(
          controller: _pageViewController,
          onPageChanged: onTabTapped,
          children: const [Timeline(), Courses(), Events()]),
    );
  }
}
