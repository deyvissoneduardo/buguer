import '../../models/auth_model.dart';
import '../../models/user_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login(String cpf, String password);
  Future<void> register(UserModel userModel);
}
