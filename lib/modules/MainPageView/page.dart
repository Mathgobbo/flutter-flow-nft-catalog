import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/Catalog/page.dart';
import 'package:flutter_flow_nft_catalog/modules/CatalogNavigator/page.dart';
import 'package:flutter_flow_nft_catalog/modules/MainPageView/controller.dart';
import 'package:flutter_flow_nft_catalog/modules/User/page.dart';
import 'package:flutter_flow_nft_catalog/modules/shared/AppBarTitle.dart';
import 'package:get/get.dart';

import '../Home/page.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FCLController());

    PageViewController controller = Get.put(PageViewController());
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: MainColors.green,
              onTap: controller.setNewPage,
              currentIndex: controller.currentPage.value,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(FeatherIcons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(FeatherIcons.book),
                  label: "Catalog",
                ),
                BottomNavigationBarItem(
                    icon: Icon(FeatherIcons.user), label: "User")
              ]),
        ),
        body: SafeArea(
          child: PageView(
            controller: controller.pageController,
            children: const [Home(), CatalogNavigator(), UserPage()],
            onPageChanged: controller.onPageChanged,
          ),
        ));
  }
}
