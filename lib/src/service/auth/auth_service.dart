import '../../models/user_model.dart';

abstract class AuthService {
  Future<void> execute({required String cpf, required String password});
  Future<void> register(UserModel userModel);
}
