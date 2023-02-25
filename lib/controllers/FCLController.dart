import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';
import 'package:flutter_flow_nft_catalog/types/User.dart';
import 'package:get/get.dart';

class FCLController extends GetxController {
  static const BATCH_SIZE = 50;
  final platformChannel =
      const MethodChannel('flowflutternftcatalog.beyonders/iOS');

  final isMainnet = true.obs;

  final List<NFTCatalogMetadata> catalog = <NFTCatalogMetadata>[];
  final List<NFTCatalogMetadata> presentableCatalog =
      <NFTCatalogMetadata>[].obs;
  final loadingCatalog = false.obs;
  String catalogSearch = "";

  final observableUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    updateFCLCurrentUser();
    getCatalog();
  }

  setCatalogSarch(String value) => catalogSearch = value;

  /// Function to setCatalogSearch and also filter the current Catalog
  filterCatalog(String? value) {
    presentableCatalog.clear();
    if (value == null || value == "") {
      setCatalogSarch("");
      presentableCatalog.addAll(catalog);
      return;
    }
    setCatalogSarch(value);
    final filteredValue =
        catalog.where((element) => filterCatalogCallback(element, value));
    presentableCatalog.addAll(filteredValue);
  }

  bool filterCatalogCallback(NFTCatalogMetadata collection, String value) {
    if (collection.contractName?.contains(value) ?? false) return true;
    if (collection.collectionDisplay?.name?.contains(value) ?? false)
      return true;
    if (collection.collectionDisplay?.externalURL?.url?.contains(value) ??
        false) return true;
    if (collection.collectionDisplay?.name?.contains(value) ?? false)
      return true;
    if (collection.contractAddress?.contains(value) ?? false) return true;

    return false;
  }

  /**
   * Function to change FCL to Testnet conig
   */
  changeToTestnet() async {
    try {
      isMainnet.value = false;
      await platformChannel.invokeMethod("changeToEmulator");
      await getCatalog();
    } catch (e) {
      print(e);
    }
  }

  /**
   * Function to change FCL to Mainnet conig
   */
  changeToMainnet() async {
    try {
      isMainnet.value = true;
      await platformChannel.invokeMethod("changeToMainnet");
      await getCatalog();
    } catch (e) {
      print(e);
    }
  }

  /// Function to get all collections from NFT Catalog, using batches to a more performant query.
  getCatalog() async {
    try {
      loadingCatalog.toggle();
      final catalogLength =
          await platformChannel.invokeMethod("getCatalogLength") as int;

      final numBatches = (catalogLength / FCLController.BATCH_SIZE).ceil();
      final batches = List.generate(numBatches, (index) {
        final start = index * FCLController.BATCH_SIZE;
        int end = start + FCLController.BATCH_SIZE;
        if (end >= catalogLength) end = catalogLength;
        return {"firstBatch": start, "secondBatch": end};
      });

      List<NFTCatalogMetadata> collections = [];
      for (final batch in batches) {
        final result = await platformChannel.invokeMethod('getCatalog', {
          "firstBatch": batch["firstBatch"],
          "secondBatch": batch["secondBatch"]
        });
        for (var i = 0; i < result.keys.toList().length; i++) {
          collections
              .add(NFTCatalogMetadata.fromJson(result.values.toList()[i]));
        }
      }

      catalog.clear();
      catalog.addAll(collections);
      filterCatalog(catalogSearch);
    } catch (e) {
      print(e);
    }
    loadingCatalog.toggle();
  }

  /// Function to get Current user from FCL API and update Local User
  updateFCLCurrentUser() async {
    //final response = await platformChannel.invokeMethod("getCurrentUser");
    final response = '{"addr": "0xf8d6e0586", "loggedIn": true, "keyId": 1}';
    if (response != null)
      observableUser.value = User.fromJson(jsonDecode(response));
    else
      observableUser.value = null;
    print(observableUser.value);
  }

  /// Authenticate FCL User!
  authenticate() async {
    try {
      final response = await platformChannel.invokeMethod("authenticate");
      print(response);
      updateFCLCurrentUser();
    } catch (e) {
      print(e);
    }
  }

  /// Authenticate FCL User!
  unauthenticate() async {
    try {
      final response = await platformChannel.invokeMethod("unauthenticate");
      print(response);
      updateFCLCurrentUser();
    } catch (e) {
      print(e);
    }
  }
}
