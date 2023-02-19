import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FCLController extends GetxController {
  final platformChannel = MethodChannel('flowflutternftcatalog.beyonders/iOS');

  final catalog = "".obs;
  getCatalog() async {
    try {
      final result = await platformChannel.invokeMethod('getCatalog');
      print(result);
      catalog.value = result.toString();
    } catch (e) {
      print(e);
    }
  }
}
