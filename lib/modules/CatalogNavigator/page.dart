import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/NavigatorKeys.dart';
import 'package:flutter_flow_nft_catalog/modules/Catalog/page.dart';
import 'package:flutter_flow_nft_catalog/modules/Collection/controller.dart';
import 'package:flutter_flow_nft_catalog/modules/Collection/page.dart';
import 'package:flutter_flow_nft_catalog/routes/Routes.dart';
import 'package:get/get.dart';

class CatalogNavigator extends StatelessWidget {
  const CatalogNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CollectionController());
    return Navigator(
      key: Get.nestedKey(NavigatorKeys.catalogNavigationId),
      initialRoute: CATALOG_ROUTE,
      onGenerateRoute: (settings) {
        if (settings.name == CATALOG_ROUTE)
          return GetPageRoute(page: () => Catalog());
        if (settings.name == COLLECTION_PAGE)
          return GetPageRoute(page: () => Collection());
      },
    );
  }
}
