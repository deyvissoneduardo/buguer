import 'package:get/get.dart';

import '../../../core/rest_client/custom_dio.dart';
import '../../../core/storage/storage.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/auth/auth_repository_impl.dart';
import '../../../service/auth/auth_service.dart';
import '../../../service/auth/auth_service_impl.dart';
import 'login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<CustomDio>()),
    );
    Get.lazyPut<AuthService>(
      () => AuthServiceImpl(
        authRepository: Get.find<AuthRepository>(),
        storage: Get.find<Storage>(),
      ),
    );
    Get.lazyPut(
      () => LoginController(
        Get.find<AuthService>(),
      ),
    );
  }
}
