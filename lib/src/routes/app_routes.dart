import 'package:get/get.dart';

import '../modules/auth/login/login_page.dart';
import '../modules/auth/register/register_page.dart';
import '../modules/home/home_page.dart';
import '../modules/products/home/products_page.dart';
import '../template/base_layout.dart';

class AppRoutes {
  static const HOME_PAGE = '/home_page';
  static const LOGIN_PAGE = '/login_page';
  static const REGISTER_PAGE = '/register';
  static const PRODUCTS_PAGE = '/products';

  static List<GetPage> pages = [
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(
      name: '/register',
      page: () => const RegisterPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: '/',
      page: () => const BaseLayout(body: HomePage()),
      transition: Transition.noTransition,
      children: [
        GetPage(
          name: '/products',
          page: () => const ProductsPage(),
        ),
      ],
    ),
  ];
}
