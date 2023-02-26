import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/AccountNFTsController.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/User/components/NFTCard.dart';
import 'package:get/get.dart';

class AccountNFTsTab extends StatefulWidget {
  const AccountNFTsTab({super.key});

  @override
  State<AccountNFTsTab> createState() => _AccountNFTsTabState();
}

class _AccountNFTsTabState extends State<AccountNFTsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FCLController fclController = Get.find();
    AccountNFTsController accountNFTsController = Get.find();

    fclController.observableUser.listen((user) {
      if (user != null) {
        accountNFTsController.getAccountNFTs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AccountNFTsController accountNFTsController = Get.find();
    return Obx(
      () => accountNFTsController.loading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: MainColors.green,
              ),
            )
          : accountNFTsController.error.value != ""
              ? Center(child: Text(accountNFTsController.error.value))
              : Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: accountNFTsController.nftsList.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                physics: const NeverScrollableScrollPhysics(),
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
                                itemCount:
                                    accountNFTsController.nftsList.length,
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        )
                      : const Text("No collections found"),
                ),
    );
  }
}
