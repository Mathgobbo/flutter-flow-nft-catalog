import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';
import 'package:get/get.dart';

class FCLController extends GetxController {
  final platformChannel = MethodChannel('flowflutternftcatalog.beyonders/iOS');

  final List<NFTCatalogMetadata> catalog = <NFTCatalogMetadata>[].obs;
  getCatalog() async {
    try {
      final result = await platformChannel.invokeMethod('getCatalog');
      print(jsonEncode(result.values.toList()[0]["nftType"]));

      List<NFTCatalogMetadata> collections = [];
      for (var i = 0; i < result.keys.toList().length; i++) {
        collections.add(NFTCatalogMetadata.fromJson(result.values.toList()[i]));
      }

      catalog.clear();
      catalog.addAll(collections);
    } catch (e) {
      print(e);
    }
  }
}
