import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeButton extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final List<Color> gradientColors;

  const HomeButton(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: gradientColors,
          )),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                const SizedBox(
                  height: 4,
                ),
                subtitle
              ],
            ),
          ),
          const Icon(FeatherIcons.chevronRight)
        ],
      ),
    );
  }
}
