import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/AffiliateDetailsController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AffiliateDetailsTab extends StatelessWidget {
  const AffiliateDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AffiliateDetailsController affiliateDetailsController = Get.find();
    affiliateDetailsController.getAffiliateDetails();

    return Obx(
      () => affiliateDetailsController.error.value != ""
          ? Center(
              child: Text(affiliateDetailsController.error.value),
            )
          : affiliateDetailsController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MainColors.green,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Affiliate details",
                          style: TextStyle(
                              fontFamily: "Termina",
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/flow-logo.svg",
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "0,00",
                            style: TextStyle(
                                fontSize: 56,
                                fontFamily: "Termina",
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const Center(
                          child: Text(
                        "Flow Available",
                        style: TextStyle(
                            color: MainColors.gray,
                            fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MainColors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Termina",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          child: const Text("Withdraw"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Payout Recipient:",
                        style: TextStyle(
                            color: MainColors.gray,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        affiliateDetailsController
                                .affiliateDetails["payoutRecipient"] ??
                            "",
                        style: const TextStyle(
                            color: MainColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Affiliate since:",
                        style: TextStyle(
                            color: MainColors.gray,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    affiliateDetailsController
                                            .affiliateDetails["created"]
                                            .round() *
                                        1000)) ??
                            "",
                        style: const TextStyle(
                            color: MainColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      const Divider(
                        color: MainColors.gray,
                      ),
                      const Text(
                        "Payout History:",
                        style: TextStyle(
                            color: MainColors.gray,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      Text("No Payouts done yet"),
                    ],
                  ),
                ),
    );
  }
}
