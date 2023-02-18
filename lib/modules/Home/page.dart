import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/Counter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              SvgPicture.asset("assets/images/flow-logo.svg"),
              SizedBox(
                width: 8,
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 24,
                        color: MainColors.black,
                        fontFamily: "Termina"),
                    children: [
                      TextSpan(
                          text: "flow ",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: "catalog")
                    ]),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Explore the Flow Catalog",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Column(
                    children: [Text("Catalog")],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
