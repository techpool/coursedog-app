import 'package:flutter/material.dart';

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
    );
  }
}
