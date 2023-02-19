import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  setNewPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    currentPage.value = index;
  }

  onPageChanged(int index) => currentPage.value = index;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
