import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/NavigatorKeys.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/Collection/controller.dart';
import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Collection extends StatelessWidget {
  Collection({super.key});

  final webViewController = WebViewController();

  _launchUrl(String? url) async {
    try {
      if (url != null && await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url));
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error when opening link",
          "Something happened when trying to open this external link.");
    }
  }

  @override
  Widget build(BuildContext context) {
    FCLController fclController = Get.find();
    CollectionController controller = Get.find();
    NFTCatalogMetadata? metadata =
        controller.collectionObserver.value.collection;

    webViewController.loadHtmlString(
        '<html><style>html,body {background: #C2185B;padding: 0;margin: 0;} img {width: 100vw; height: 100vh;}</style><body>' +
            '<img src="${metadata?.collectionDisplay?.squareImage?.file?.url ?? ""}" /> ' +
            '</body></html>');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () =>
                    Get.back(id: NavigatorKeys.catalogNavigationId),
                icon: Icon(FeatherIcons.chevronLeft)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    metadata?.collectionDisplay?.squareImage?.file?.url ?? "",
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: Get.size.width * 0.45,
                      width: Get.size.width * 0.45,
                      child: WebViewWidget(
                        controller: webViewController,
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: (loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 100)),
                          ),
                        );
                      }
                    },
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                metadata?.collectionDisplay?.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Termina",
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                metadata?.collectionDisplay?.description ?? "",
                style: const TextStyle(
                    color: MainColors.gray, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                metadata?.collectionDisplay?.externalURL != null
                    ? GestureDetector(
                        onTap: () => _launchUrl(
                            metadata?.collectionDisplay?.externalURL?.url),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: MainColors.green,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                          child: const Icon(
                            FeatherIcons.globe,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Spacer(),
                metadata?.collectionDisplay?.socials?.twitter != null
                    ? GestureDetector(
                        onTap: () => _launchUrl(
                            metadata?.collectionDisplay?.socials?.twitter?.url),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                metadata?.collectionDisplay?.socials?.discord != null
                    ? GestureDetector(
                        onTap: () => _launchUrl(
                            metadata?.collectionDisplay?.socials?.discord?.url),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.discord,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                //Container(
                //  width: 40,
                //  height: 40,
                //  child: Center(
                //    child: FaIcon(
                //      FontAwesomeIcons.instagram,
                //      color: Colors.white,
                //      size: 24,
                //    ),
                //  ),
                //  padding: EdgeInsets.all(0),
                //  decoration: BoxDecoration(
                //      image: DecorationImage(
                //          image: AssetImage("assets/images/instagram-bg.png"),
                //          fit: BoxFit.cover),
                //      boxShadow: [
                //        BoxShadow(
                //            color: Colors.black.withOpacity(0.5),
                //            blurRadius: 1,
                //            spreadRadius: 0)
                //      ],
                //      borderRadius: BorderRadius.all(Radius.circular(100))),
                //),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Contract Details",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "Termina",
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () => _launchUrl(
                  'https://${!fclController.isMainnet.value ? "testnet." : ""}flowscan.org/contract/A.${metadata?.contractAddress}.${metadata?.contractName}'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: MainColors.gray.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/flowscan.svg",
                      width: 12,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "View Contract",
                      style: TextStyle(
                          color: MainColors.gray, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ContractDetail(
                title: "Type:",
                value: metadata?.nftType?.staticType?.typeID ?? ''),
            const SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Address:", value: metadata?.contractAddress ?? ''),
            const SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Storage Path:",
                value:
                    "/${metadata?.collectionData?.storagePath?.domain ?? ''}/${metadata?.collectionData?.storagePath?.identifier ?? ''}"),
            const SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Public Path:",
                value:
                    "/${metadata?.collectionData?.publicPath?.domain ?? ''}/${metadata?.collectionData?.publicPath?.identifier ?? ''}"),
            const SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Private Path:",
                value:
                    "/${metadata?.collectionData?.privatePath?.domain ?? ''}/${metadata?.collectionData?.privatePath?.identifier ?? ''}"),
            const SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Public Type:",
                value: metadata?.collectionData?.publicLinkedType?.staticType
                        ?.typeID ??
                    ''),
            SizedBox(
              height: 8,
            ),
            ContractDetail(
                title: "Private Type:",
                value: metadata?.collectionData?.privateLinkedType?.staticType
                        ?.typeID ??
                    ''),
          ],
        ),
      ),
    );
  }
}

class ContractDetail extends StatelessWidget {
  final String title;
  final String value;
  const ContractDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: MainColors.gray),
        )
      ],
    );
  }
}
