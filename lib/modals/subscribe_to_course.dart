import 'package:coursedog_app/components/common/bottomsheet_topbar.dart';
import 'package:coursedog_app/models/course.dart';
import 'package:coursedog_app/models/section.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/utils/api.dart' as api;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SubscribeToCourse extends StatefulWidget {
  const SubscribeToCourse({super.key});

  @override
  State<SubscribeToCourse> createState() => _SubscribeToCourseState();
}

class _SubscribeToCourseState extends State<SubscribeToCourse> {
  Course? selectedCourse;
  Section? selectedSection;

  void setSelectedCourse(Course course) {
    setState(() {
      selectedCourse = course;
      selectedSection = null;
    });
  }

  void setSelectedSection(Section section) {
    setState(() {
      selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      const BottomsheetTopbar(title: 'Subscribe to Course'),
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownSearch<Course>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(labelText: "Name"),
            ),
            selectedItem: selectedCourse,
            asyncItems: (String filter) async {
              var response = await api.fetchCourses(
                  school: Provider.of<UserNotifier>(context, listen: false)
                      .selectedSchool!,
                  term: Provider.of<TermNotifier>(context, listen: false)
                      .selectedTerm!,
                  searchQuery: filter);
              return response;
            },
            onChanged: (Course? data) {
              if (data != null) {
                setSelectedCourse(data);
              }
            },
          )),
      if (selectedCourse != null)
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownSearch<Section>(
              popupProps: const PopupProps.menu(showSearchBox: true),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(labelText: "Section"),
              ),
              items: selectedCourse!.sections,
              selectedItem: selectedSection,
              onChanged: (Section? data) {
                if (data != null) {
                  setSelectedSection(data);
                }
              },
            )),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonBar(
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedSection != null) {
                  Provider.of<FavouritesNotifier>(context, listen: false)
                      .addCourseFavourite(
                          courseId: selectedCourse!.id,
                          sectionId: selectedSection!.id);
                  Get.back();
                }
              },
              child: const Text('Subscribe'),
            ),
          ],
        ),
      )
    ]);
  }
}

void openSubscribeToCourse(BuildContext context) {
  Get.bottomSheet(const SubscribeToCourse(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      ignoreSafeArea: false);
}
