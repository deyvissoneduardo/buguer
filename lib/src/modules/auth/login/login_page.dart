import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/ui/core_ui.dart';
import '../../../routes/app_routes.dart';
import 'login_controller.dart';
import 'widgets/form_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = LoginController();

  void _formSubmit() {
    final formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      controller.login(
        cpfEC.text,
        passwordEC.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    switch (controller.loginStatus.value) {
      case LoginStateStatus.initial:
        break;
      case LoginStateStatus.loading:
        showLoader();
        break;
      case LoginStateStatus.success:
        hiderLoader();
        Get.toNamed(AppRoutes.LOGIN_PAGE);
        break;
      case LoginStateStatus.error:
        hiderLoader();
        showError(controller.erroMessage.value);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cpfEC.dispose();
    passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: context.colors.black,
          body: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const LunchWidget(),
                const LogoWidget(),
                FormLogin(
                  cpfEC: cpfEC,
                  passwordEC: passwordEC,
                  onFieldSubmitted: (_) => _formSubmit(),
                  onPressed: () => _formSubmit(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
