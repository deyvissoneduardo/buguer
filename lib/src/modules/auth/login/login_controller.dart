import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/exception/unauthorized_exception.dart';
import '../../../service/auth/auth_service.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error,
}

class LoginController extends GetxController {
  final AuthService _authService;

  final loginStatus = Rx<LoginStateStatus>(LoginStateStatus.initial);

  final errorMessage = Rx<String?>(null);

  LoginController(this._authService);

  Future<void> login(String cpf, String password) async {
    try {
      loginStatus.value = LoginStateStatus.loading;
      await _authService.execute(cpf: cpf, password: password);
      loginStatus.value = LoginStateStatus.success;
    } on UnauthorizedException {
      errorMessage.value = 'Login ou senha inválidos';
      loginStatus.value = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      errorMessage.value = 'Tente novamente mais tarde';
      loginStatus.value = LoginStateStatus.error;
    }
  }
}
