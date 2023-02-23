import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/AccountNFTsController.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/User/components/NFTCard.dart';
import 'package:get/get.dart';

class UserTabBar extends StatefulWidget {
  const UserTabBar({super.key});

  @override
  State<UserTabBar> createState() => _UserTabBarState();
}

class _UserTabBarState extends State<UserTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final FCLController fclController = Get.find();

    fclController.isMainnet.listen((isMainnet) {
      AccountNFTsController accountNFTsController = Get.find();
      accountNFTsController.getAccountNFTs();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountNFTsController accountNFTsController = Get.find();
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: MainColors.black,
            dividerColor: MainColors.secondaryGray,
            indicatorWeight: 3,
            indicatorColor: MainColors.gray.withOpacity(0.2),
            tabs: const [
              Tab(
                icon: Icon(
                  FeatherIcons.image,
                ),
                height: 36,
              ),
              Tab(
                icon: Icon(FeatherIcons.dollarSign),
                height: 36,
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            Obx(
              () => accountNFTsController.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: MainColors.green,
                      ),
                    )
                  : accountNFTsController.error.value != ""
                      ? Center(child: Text(accountNFTsController.error.value))
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 20, left: 20),
                          child: accountNFTsController.nftsList.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total of NFTs: ${accountNFTsController.nftsList.length}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: MainColors.gray),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                childAspectRatio: 0.89,
                                                crossAxisSpacing: 16,
                                                mainAxisSpacing: 16),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return NFTCard(
                                              nft: accountNFTsController
                                                  .nftsList.value[index]);
                                        },
                                        itemCount: accountNFTsController
                                            .nftsList.length,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      )
                                    ],
                                  ),
                                )
                              : const Text("No collections found"),
                        ),
            ),
            const Center(
              child: Text("Coming Soon!"),
            )
          ],
        ))
      ],
    );
  }
}
