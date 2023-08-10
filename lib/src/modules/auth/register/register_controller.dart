import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../service/auth/auth_service.dart';

enum RegisterStateStatus {
  initial,
  loading,
  success,
  error;
}

class RegisterController extends GetxController {
  final AuthService? authService;

  var registerStatus = RegisterStateStatus.initial.obs;

  var erroMessage = ''.obs;

  RegisterController({this.authService});

  Future<void> register(UserModel userModel) async {
    try {
      registerStatus.value = RegisterStateStatus.loading;
      await authService!.register(userModel);
      await authService!.execute(
        cpf: userModel.cpf,
        password: userModel.password,
      );
      registerStatus.value = RegisterStateStatus.success;
    } catch (e, s) {
      log('Error ao cadastrar - se', error: e, stackTrace: s);
      erroMessage.value = 'Tente Novamente mais tarde';
      registerStatus.value = RegisterStateStatus.error;
    }
  }
}
