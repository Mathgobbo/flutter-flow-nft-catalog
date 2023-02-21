import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/NavigatorKeys.dart';
import 'package:flutter_flow_nft_catalog/modules/Collection/controller.dart';
import 'package:flutter_flow_nft_catalog/routes/Routes.dart';
import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';
import 'package:get/get.dart';

import '../../../Theme.dart';

class CollectionCard extends StatelessWidget {
  final NFTCatalogMetadata collection;

  const CollectionCard({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CollectionController>().setSelectedCollection(collection);
        Get.toNamed(COLLECTION_PAGE, id: NavigatorKeys.catalogNavigationId);
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(
                color: MainColors.gray,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.collectionDisplay?.name ?? "",
                      style: TextStyle(
                          fontFamily: "Termina",
                          fontSize: 24,
                          color: MainColors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      collection.nftType?.staticType?.typeID ?? "",
                      style: TextStyle(color: MainColors.gray),
                    ),
                    //SizedBox(
                    //  height: 32,
                    //),
                    //ElevatedButton(
                    //    style: ElevatedButton.styleFrom(
                    //      backgroundColor: MainColors.secondaryGray,
                    //    ),
                    //    onPressed: () => {},
                    //    child: Text(
                    //      "View Contract",
                    //      style: TextStyle(color: Colors.black),
                    //    ))
                  ],
                ),
              ),
              const Icon(FeatherIcons.chevronRight)
            ],
          )),
    );
  }
}
