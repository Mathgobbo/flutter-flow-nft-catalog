import 'package:flutter/material.dart';
import 'package:flutter_flow_nft_catalog/Routes.dart';
import 'package:flutter_flow_nft_catalog/modules/Home/page.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      theme: ThemeData(
        fontFamily: 'Termina',
      ),
    ));
