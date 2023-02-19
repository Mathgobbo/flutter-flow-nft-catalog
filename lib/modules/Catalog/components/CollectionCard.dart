import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../Theme.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(
              color: MainColors.gray,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NFLAllDay",
                    style: TextStyle(
                        fontFamily: "Termina",
                        fontSize: 24,
                        color: MainColors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "A.0b2a3299cc857e29.TopShot.NFT",
                    style: TextStyle(color: MainColors.gray),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColors.secondaryGray,
                      ),
                      onPressed: () => {},
                      child: Text(
                        "View Contract",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
            const Icon(FeatherIcons.chevronRight)
          ],
        ));
  }
}
