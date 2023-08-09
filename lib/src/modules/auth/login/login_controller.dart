import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/exception/unauthorized_exception.dart';
import '../../../service/auth/auth_service.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error;
}

class LoginController extends GetxController {
  final AuthService? authService;

  var loginStatus = LoginStateStatus.initial.obs;

  var erroMessage = ''.obs;

  LoginController({this.authService});

  Future<void> login(String cpf, String password) async {
    try {
      loginStatus.value = LoginStateStatus.loading;
      await authService!.execute(cpf: cpf, password: password);
      loginStatus.value = LoginStateStatus.success;
    } on UnauthorizedException {
      erroMessage.value = 'Login ou senha invalidos';
      loginStatus.value = LoginStateStatus.error;
    } catch (e, s) {
      log('Error ao realizar login', error: e, stackTrace: s);
      erroMessage.value = 'Tente Novamente mais tarde';
      loginStatus.value = LoginStateStatus.error;
    }
  }
}
