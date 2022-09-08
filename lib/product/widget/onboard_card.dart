import 'package:flutter/material.dart';
import 'package:flutter_provider_example/future/onboard/onboard_model.dart';

class OnboardCard extends StatelessWidget {
  const OnboardCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          model.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(model.description),
        Image.asset(model.imageWithPath),
      ],
    );
  }
}
