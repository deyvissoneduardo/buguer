import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/core/env/env.dart';
import 'src/core/ui/theme/theme_config.dart';
import 'src/modules/auth/login/login_page.dart';
import 'src/modules/core/core_bindings.dart';
import 'src/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  runApp(
    GetMaterialApp(
      theme: ThemeConfig.theme,
      initialBinding: CoreBindings(),
      initialRoute: AppRoutes.LOGIN_PAGE,
      getPages: AppRoutes.pages,
      home: const LoginPage(),
      enableLog: true,
    ),
  );
}
