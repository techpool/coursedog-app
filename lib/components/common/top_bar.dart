import 'package:coursedog_app/modals/show_term_selector.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool hideBackButton;
  final bool showTermSelector;
  const TopBar(
      {super.key,
      this.title = 'Coursedog',
      this.hideBackButton = false,
      this.showTermSelector = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showTermSelector
          ? IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                openTermSelectorModal(context);
              },
            )
          : null,
      automaticallyImplyLeading: !hideBackButton,
      actions: [
        IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            Provider.of<UserNotifier>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}
