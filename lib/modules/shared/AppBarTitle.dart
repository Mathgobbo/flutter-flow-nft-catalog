import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../Theme.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/images/flow-logo.svg"),
        const SizedBox(
          width: 8,
        ),
        RichText(
          text: const TextSpan(
              style: TextStyle(
                  fontSize: 24, color: MainColors.black, fontFamily: "Termina"),
              children: [
                TextSpan(
                    text: "flow ",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: "catalog")
              ]),
        )
      ],
    );
  }
}
