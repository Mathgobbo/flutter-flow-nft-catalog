import 'package:flutter/material.dart';
import 'package:flutter_flow_nft_catalog/NavigatorKeys.dart';
import 'package:flutter_flow_nft_catalog/routes/Pages.dart';
import 'package:flutter_flow_nft_catalog/modules/Home/page.dart';
import 'package:flutter_flow_nft_catalog/routes/Routes.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(
      initialRoute: MAIN,
      getPages: routes,
      theme: ThemeData(),
    ));
