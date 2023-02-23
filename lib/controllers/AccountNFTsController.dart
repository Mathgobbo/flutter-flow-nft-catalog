import 'dart:convert';

import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/types/NFT.dart';
import 'package:get/get.dart';

class AccountNFTsController extends GetxController {
  final nftsList = <NFT>[].obs;
  final loading = false.obs;
  final error = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAccountNFTs();
  }

  getAccountNFTs() async {
    try {
      error.value = "";
      loading.value = true;

      FCLController fclController = Get.find();

      if (fclController.observableUser.value == null) {
        error.value = "User not Logged in";
        loading.value = false;
        return;
      }

      final response = await fclController.platformChannel.invokeMethod(
          "getAccountNFTs",
          {"address": fclController.observableUser.value?.addr});

      final nfts = <NFT>[];
      for (var collection in response.values.toList()) {
        for (var nft in collection) {
          nfts.add(NFT.fromJson(nft));
        }
      }

      nftsList.clear();
      nftsList.addAll(nfts);
    } catch (e) {
      print(e);
      error.value = "An error ocurred when getting your NFTs.";
    }
    loading.value = false;
  }
}
