import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exception/respository_exception.dart';
import '../../core/exception/unauthorized_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/auth_model.dart';
import '../../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<AuthModel> login(String cpf, String password) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {
          'cpf': cpf,
          'password': password,
        },
      );

      return AuthModel.fromMap(result.data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) {
        log('Login ou Senha inválidos', error: e.error, stackTrace: s);
        throw UnauthorizedException();
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw const RespositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> register(UserModel userModel) async {
    try {
      final result = await _dio.unauth().post(
            '/register',
            data: userModel.toJson(),
          );
      return result.data;
    } on DioException catch (e, s) {
      log('Erro ao cadastrar-se', error: e, stackTrace: s);
      throw const RespositoryException(message: 'Erro ao cadastrar-se');
    }
  }
}
