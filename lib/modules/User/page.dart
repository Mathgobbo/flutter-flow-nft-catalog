import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:flutter_flow_nft_catalog/modules/User/components/LogInForm.dart';
import 'package:flutter_flow_nft_catalog/modules/User/components/UserTabBar.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FCLController fclController = Get.find();
    return Obx(() => fclController.observableUser.value != null
        ? UserPageContent()
        : LoginForm());
  }
}

class UserPageContent extends StatelessWidget {
  const UserPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FCLController fclController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: "Termina",
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => Text(
                      fclController.observableUser.value?.addr ?? "",
                      style: const TextStyle(
                          fontSize: 20,
                          color: MainColors.gray,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: MainColors.green.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: MainColors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(() => Text(
                              fclController.isMainnet.value
                                  ? "Mainnet"
                                  : "Testnet",
                              style: const TextStyle(
                                  fontFamily: "Termina",
                                  fontWeight: FontWeight.w700,
                                  color: MainColors.gray),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              FeatherIcons.repeat,
                              size: 16,
                              color: MainColors.gray,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: fclController.unauthenticate,
                  icon: const Icon(FeatherIcons.logOut))
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Expanded(child: UserTabBar())
      ],
    );
  }
}
