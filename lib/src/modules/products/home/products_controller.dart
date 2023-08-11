import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/product_model.dart';
import '../../../service/products/products_service.dart';

enum ProductStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdateProduct,
}

class ProductsController extends GetxController {
  final ProductService productService;

  ProductsController(this.productService);

  final status = ProductStateStatus.initial.obs;

  final products = <ProductModel>[].obs;

  RxString? filterName;

  final Rx<ProductModel?> productSelected = Rx<ProductModel?>(null);

  Future<void> filterByName(String name) async {
    filterName = name.obs;
    await loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      status.value = ProductStateStatus.loading;
      products.value = await productService.finalAll(filterName?.value);
      status.value = ProductStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      status.value = ProductStateStatus.error;
    }
  }

  Future<void> addProduct() async {
    status.value = ProductStateStatus.loading;
    await Future.delayed(Duration.zero);
    productSelected.value = null;
    status.value = ProductStateStatus.addOrUpdateProduct;
  }

  Future<void> editProduct(ProductModel productModel) async {
    status.value = ProductStateStatus.loading;
    await Future.delayed(Duration.zero);
    productSelected.value = productModel;
    status.value = ProductStateStatus.addOrUpdateProduct;
  }
}
