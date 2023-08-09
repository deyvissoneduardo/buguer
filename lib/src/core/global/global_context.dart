import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/storage.dart';

final class GlobalContext {
  static GlobalContext? _instance;

  late final GlobalKey<NavigatorState> _navigatorkey;

  GlobalContext._();

  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> navigationKey) =>
      _navigatorkey = navigationKey;

  void loginExpire() {
    Get.find<Storage>().clean();
    ScaffoldMessenger.of(_navigatorkey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(top: 72),
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Login Expirado',
          message: 'Login Expirado, faça login novamente',
          contentType: ContentType.failure,
        ),
      ),
    );
    Get.offAll('/login');
  }
}
