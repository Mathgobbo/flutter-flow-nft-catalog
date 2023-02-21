import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/Catalog/components/CatalogTabBar.dart';
import 'package:get/get.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final FCLController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 24,
      ),
      const Text(
        "View Catalog",
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 36, fontFamily: "Termina"),
      ),
      const SizedBox(
        height: 8,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: MainColors.green,
                ),
          ),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  FeatherIcons.search,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MainColors.green),
                    borderRadius: BorderRadius.circular(8)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Search'),
          ),
        ),
      ),
      const SizedBox(height: 32),
      const Expanded(child: CatalogTabBar())
    ]);
  }
}
