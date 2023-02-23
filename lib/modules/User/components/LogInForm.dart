import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';
import 'package:flutter_flow_nft_catalog/controllers/FCLController.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final FCLController fclController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Sign In",
          style: TextStyle(
              fontSize: 36, fontFamily: "Termina", fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          "And see all you NFTs and more stuff from the Flow Community",
          style: TextStyle(color: MainColors.gray, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 6,
        ),
        ElevatedButton(
          onPressed: fclController.authenticate,
          style: ElevatedButton.styleFrom(
              backgroundColor: MainColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Termina",
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
          child: const Text("Sign In Now!"),
        )
      ],
    );
  }
}
