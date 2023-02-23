import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/modules/MainPageView/controller.dart';
import 'package:flutter_flow_nft_catalog/modules/shared/AppBarTitle.dart';
import 'package:get/get.dart';

import 'components/HomeButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final PageViewController pageViewController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Explore the Flow Catalog",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                fontFamily: "Termina"),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Build your next idea using Flow NFT collections.",
            style: TextStyle(color: MainColors.gray, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 24,
          ),
          HomeButton(
            title: const Text(
              "Flow Catalog",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  fontFamily: "Termina"),
            ),
            subtitle: const Text(
              "Browse NFT collections on the catalog and view their collection-level data",
              style: TextStyle(color: MainColors.gray, fontSize: 16),
            ),
            gradientColors: [
              MainColors.green.withOpacity(0.9),
              MainColors.green.withOpacity(0.5)
            ],
            onPressed: () => pageViewController.setNewPage(1),
          ),
          const SizedBox(
            height: 12,
          ),
          HomeButton(
            title: const Text(
              "View NFTs",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Termina"),
            ),
            subtitle: const Text(
              "Build your next idea using Flow NFT collections.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            gradientColors: [
              MainColors.purple.withOpacity(0.9),
              MainColors.purple.withOpacity(0.5)
            ],
            onPressed: () => pageViewController.setNewPage(2),
          ),
        ],
      ),
    );
  }
}
