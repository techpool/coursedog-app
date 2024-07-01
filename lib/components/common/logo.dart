import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CoursedogLogo extends StatelessWidget {
  final double height;
  const CoursedogLogo({super.key, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'images/logo.svg';
    return Column(children: [
      SvgPicture.asset(
        assetName,
        semanticsLabel: 'Coursedog Logo',
        height: height,
      ),
      const Gap(10.0), // Add this line
      const Text('Coursedog', style: TextStyle(fontSize: 24.0)),
    ]);
  }
}
