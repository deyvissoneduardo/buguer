import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/core_ui.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Loader, Messages {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<RegisterController>();

  @override
  void initState() {
    switch (controller.registerStatus.value) {
      case RegisterStateStatus.initial:
        break;
      case RegisterStateStatus.loading:
        showLoader();
        break;
      case RegisterStateStatus.success:
        hiderLoader();
        Get.toNamed(AppRoutes.HOME_PAGE);
        break;
      case RegisterStateStatus.error:
        hiderLoader();
        showError(controller.erroMessage.value);
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    cpfEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  void _formSubmit() {
    controller.registerStatus.value = RegisterStateStatus.loading;
    final formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      controller.register(
        UserModel(
          name: nameEC.text.trim(),
          email: emailEC.text.trim(),
          cpf: cpfEC.text.trim(),
          password: passwordEC.text.trim(),
        ),
      );
    }
    controller.registerStatus.value = RegisterStateStatus.success;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const LunchWidget(),
            const LogoWidget(),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.percentWidth(screenWidth < 1300 ? .7 : .3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .3,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Cadastre - se',
                            style: context.textStyles.textTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: nameEC,
                          onFieldSubmitted: (_) => _formSubmit,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(labelText: 'Nome'),
                          validator: Validatorless.multiple([
                            Validatorless.required('campo obrigatorio'),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailEC,
                          onFieldSubmitted: (_) => _formSubmit,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              const InputDecoration(labelText: 'E-mail'),
                          validator: Validatorless.multiple([
                            Validatorless.required('campo obrigatorio'),
                            Validatorless.email('e-mail invalido'),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: cpfEC,
                          onFieldSubmitted: (_) => _formSubmit,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MasksFormts.maskFormatterCPF],
                          decoration: const InputDecoration(labelText: 'CPF'),
                          validator: Validatorless.multiple([
                            Validatorless.required('campo obrigatorio'),
                            Validatorless.cpf('cpf invalido'),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordEC,
                          onFieldSubmitted: (_) => _formSubmit,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: 'Senha'),
                          validator: Validatorless.multiple([
                            Validatorless.required('senha e obrigatorio'),
                            Validatorless.min(6, 'minimo de 6 caracters')
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _formSubmit();
                            },
                            child: Text(
                              'Cadastrar',
                              style: context.textStyles.textBold
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
