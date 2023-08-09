import '../../core/global/constantes.dart';
import '../../core/storage/storage.dart';
import '../../models/user_model.dart';
import '../../repositories/auth/auth_repository.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository _authRepository;
  final Storage _storage;

  const AuthServiceImpl({
    required AuthRepository authRepository,
    required Storage storage,
  })  : _authRepository = authRepository,
        _storage = storage;

  @override
  Future<void> execute({
    required String cpf,
    required String password,
  }) async {
    final authModel = await _authRepository.login(
      cpf,
      password,
    );

    return _storage.setData(
      SessionStorageKeys.accessToken.key,
      authModel.accessToken,
    );
  }

  @override
  Future<void> register(UserModel userModel) =>
      _authRepository.register(userModel);
}
