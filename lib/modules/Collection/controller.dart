import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';
import 'package:get/get.dart';

class ObservableNFTCatalogMetadata {
  NFTCatalogMetadata? collection;
}

class CollectionController extends GetxController {
  final collectionObserver = ObservableNFTCatalogMetadata().obs;

  setSelectedCollection(NFTCatalogMetadata collection) =>
      this.collectionObserver.update((val) {
        val?.collection = collection;
      });
}
