import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:get/get.dart';

class AffiliateDetailsController extends GetxController {
  final loading = false.obs;
  final error = "".obs;
  final affiliateDetails = Rxn<Map<dynamic, dynamic>>({});

  getAffiliateDetails() async {
    loading.value = true;
    error.value = "";
    try {
      final FCLController fclController = Get.find();
      final loggedUser = fclController.observableUser.value;
      if (loggedUser == null || fclController.isMainnet.value) return;
      final response = await fclController.platformChannel.invokeMethod(
          "getAccountBeyondAffiliate", {"address": loggedUser.addr});
      affiliateDetails.value = response;
    } catch (e) {
      print(e);
      error.value = e.toString();
    }
    loading.value = false;
  }

  mintBeyondNFT() async {
    loading.value = true;
    error.value = "";
    try {
      final FCLController fclController = Get.find();
      final loggedUser = fclController.observableUser.value;
      if (loggedUser == null || fclController.isMainnet.value) return;
      final txId =
          await fclController.platformChannel.invokeMethod("mintBeyondNFT");
      if (txId == "unauthenticated") throw txId;
      print(txId);
    } catch (e) {
      print(e);
      error.value = e.toString();
    }
    loading.value = false;
  }
}
