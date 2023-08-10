import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/auth/login/login_bindings.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/register/register_bindings.dart';
import '../modules/auth/register/register_page.dart';
import '../modules/home/home_page.dart';

class AppRoutes {
  static const HOME_PAGE = '/home_page';
  static const LOGIN_PAGE = '/login_page';
  static const REGISTER_PAGE = '/register';

  static List<GetPage<Widget>> pages = [
    GetPage(
      name: HOME_PAGE,
      page: () => const HomePage(),
    ),
    GetPage(
      name: LOGIN_PAGE,
      page: () => const LoginPage(),
      binding: LoginBindings(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: REGISTER_PAGE,
      transition: Transition.leftToRight,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
    )
  ];
}
