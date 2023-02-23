import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/types/NFT.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NFTCard extends StatelessWidget {
  final NFT nft;
  const NFTCard({super.key, required this.nft});

  /// Funtion to Build the correct image
  /// Because it can be a simple img
  /// or a SVG
  /// or an IPFS image
  _buildImage(String url, {double? width = 120, double? height = 120}) {
    final webViewController = WebViewController();
    webViewController.loadHtmlString(
        '<html><style>html,body {background: #FFF;padding: 0;margin: 0;} img {width: 100vw; height: 100vh;}</style><body><img src="${nft.thumbnail ?? ""}" /> </body></html>');
    if (url.contains(".svg")) {
      return SizedBox(
        height: width,
        width: height,
        child: WebViewWidget(
          controller: webViewController,
        ),
      );
    } else {
      String parsedUrl = url;
      if (url.contains("ipfs://")) {
        parsedUrl = "https://ipfs.io/ipfs/${url.split("ipfs://")[1]}";
      }

      return Image.network(parsedUrl,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) => SizedBox(
                height: width,
                width: height,
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
                  color: MainColors.green,
                  value: (loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 100)),
                ),
              );
            }
          });
    }
  }

  /// Function to build the Bottom Sheet
  /// SHowing the NFT with more details
  _openBottomSheet() {
    final webViewController = WebViewController();
    webViewController.loadHtmlString(
        '<html><style>html,body {background: #FFF;padding: 0;margin: 0;} img {width: 100vw; height: 100vh;}</style><body><img src="${nft.collectionSquareImage ?? ""}" /> </body></html>');

    Get.bottomSheet(
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
          child: Column(
            children: [
              Text(
                nft.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Termina",
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              ClipRRect(
                child: _buildImage(nft.thumbnail ?? "",
                    width: Get.size.width * 0.5, height: Get.size.width * 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                nft.description ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: MainColors.gray, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Collection Details",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Termina",
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.network(
                        nft.collectionSquareImage ?? "",
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 85,
                          width: 85,
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
                                    (loadingProgress.expectedTotalBytes ??
                                        100)),
                              ),
                            );
                          }
                        },
                        width: Get.size.width / 2,
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text(
                    nft.collectionName ?? "",
                    style: const TextStyle(
                        fontFamily: "Termina",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                nft.collectionDescription ?? "",
                style: const TextStyle(
                    color: MainColors.gray, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openBottomSheet,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: MainColors.black.withOpacity(0.1))
            ]),
        child: Column(
          children: [
            nft.thumbnail != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: _buildImage(nft.thumbnail as String),
                  )
                : const SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  nft.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Termina",
                    fontWeight: FontWeight.w700,
                    color: MainColors.gray,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
