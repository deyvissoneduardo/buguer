import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/auth/login/login_bindings.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/home/home_page.dart';

class AppRoutes {
  static const HOME_PAGE = 'home_page';
  static const LOGIN_PAGE = 'login_page';
  static const REGISTER_PAGE = 'register_page';

  static List<GetPage<Widget>> pages = [
    GetPage(
      name: HOME_PAGE,
      page: () => const HomePage(),
    ),
    GetPage(
      name: LOGIN_PAGE,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    )
  ];
}
