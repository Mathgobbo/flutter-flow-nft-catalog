import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/Catalog/components/CollectionCard.dart';
import 'package:get/get.dart';

class CatalogTabBar extends StatefulWidget {
  const CatalogTabBar({super.key});

  @override
  State<CatalogTabBar> createState() => _CatalogTabBarState();
}

class _CatalogTabBarState extends State<CatalogTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FCLController controller = Get.find();

    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: MainColors.black,
            dividerColor: MainColors.secondaryGray,
            labelStyle: const TextStyle(
                fontFamily: "Termina",
                fontWeight: FontWeight.w700,
                fontSize: 16),
            indicatorWeight: 4,
            indicatorColor: MainColors.green,
            tabs: const [
              Tab(
                text: "Mainnet",
                height: 28,
              ),
              Tab(
                text: "Testnet",
                height: 28,
              )
            ]),
        Expanded(
            child: TabBarView(controller: _tabController, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
            child: Obx(
              () => controller.catalog.length > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CollectionCard(
                        collection: controller.catalog[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: controller.catalog.length,
                    )
                  : Text("Loading..."),
            ),
          ),
          Text("Testnet")
        ]))
      ],
    );
  }
}
