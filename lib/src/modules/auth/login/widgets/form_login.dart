import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/core_ui.dart';
import '../../../../routes/app_routes.dart';

class FormLogin extends StatelessWidget {
  final VoidCallback? onPressed;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? cpfEC;
  final TextEditingController? passwordEC;

  const FormLogin({
    Key? key,
    required this.cpfEC,
    required this.passwordEC,
    required this.onFieldSubmitted,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Align(
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
                    'Login',
                    style: context.textStyles.textTitle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cpfEC,
                  onFieldSubmitted: onFieldSubmitted,
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
                  onFieldSubmitted: onFieldSubmitted,
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
                    onPressed: onPressed,
                    child: Text(
                      'ENTRAR',
                      style: context.textStyles.textBold
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.REGISTER_PAGE);
                  },
                  child: Text(
                    'Cadastrar-se',
                    style: context.textStyles.textExtraBold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
