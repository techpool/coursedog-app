import 'package:coursedog_app/notifiers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool hideBackButton;
  const TopBar(
      {super.key, this.title = 'Coursedog', this.hideBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
