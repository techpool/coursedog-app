import 'package:coursedog_app/components/common/bottomsheet_topbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeToCourse extends StatelessWidget {
  const SubscribeToCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(children: [
      BottomsheetTopbar(title: 'Subscribe to Course'),
      SizedBox(
          height: 300,
          // DropdownSearch<UserModel>(
          //   dropdownSearchDecoration: InputDecoration(labelText: "Name"),
          //   asyncItems: (String filter) async {
          //     var response = await Dio().get(
          //       "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
          //       queryParameters: {"filter": filter},
          //     );
          //     var models = UserModel.fromJsonList(response.data);
          //     return models;
          //   },
          //   onChanged: (UserModel? data) {
          //     print(data);
          //   },
          // ))
          child: Placeholder())
    ]);
  }
}

void openSubscribeToCourse(BuildContext context) {
  Get.bottomSheet(const SubscribeToCourse(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      ignoreSafeArea: false);
}
