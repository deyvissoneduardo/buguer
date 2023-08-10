import 'package:get/get.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import '../../service/products/products_service.dart';
import '../../service/products/products_service_impl.dart';
import 'products_controller.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find<CustomDio>()),
    );
    Get.lazyPut<ProductService>(
      () => ProductsServiceImpl(Get.find<ProductRepository>()),
    );
    Get.lazyPut(
      () => ProductsController(Get.find<ProductService>()),
    );
  }
}
