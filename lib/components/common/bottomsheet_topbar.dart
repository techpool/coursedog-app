import 'package:flutter/material.dart';

class BottomsheetTopbar extends StatelessWidget {
  final String title;
  const BottomsheetTopbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
