import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../models/product_model.dart';
import '../../../service/products/products_service.dart';

enum ProductDetailStateStatus {
  initial,
  loading,
  loaded,
  error,
  errorLoadProduct,
  deleted,
  uploaded,
  saved,
}

class ProductDetailController extends GetxController {
  final ProductService productService;

  var status = ProductDetailStateStatus.initial.obs;
  var errorMessage = RxString('');
  var imagePath = RxString('');
  var productModel = Rxn<ProductModel>();

  ProductDetailController(this.productService);

  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    status.value = ProductDetailStateStatus.loading;
    try {
      imagePath.value = await productService.uploadImageProduct(file, fileName);
      status.value = ProductDetailStateStatus.uploaded;
    } catch (e, s) {
      log('Erro ao fazer upload da imagem', error: e, stackTrace: s);
      errorMessage.value = 'Erro ao fazer upload da imagem';
      status.value = ProductDetailStateStatus.error;
    }
  }

  Future<void> save(
    String name,
    double price,
    String description,
  ) async {
    status.value = ProductDetailStateStatus.loading;
    final model = ProductModel(
      id: productModel.value!.id,
      name: name,
      description: description,
      price: price,
      image: imagePath.value,
      enabled: productModel.value?.enabled ?? true,
    );
    try {
      await productService.save(model);
      status.value = ProductDetailStateStatus.saved;
    } catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);
      status.value = ProductDetailStateStatus.error;
      errorMessage.value = 'Erro ao salvar o produto';
    }
  }

  Future<void> loadProduct(int? id) async {
    try {
      status.value = ProductDetailStateStatus.loading;
      productModel.value = null;
      imagePath.value = '';
      if (id != null) {
        productModel.value = await productService.getProduct(id);
        imagePath.value = productModel.value!.image;
      }
      status.value = ProductDetailStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar produto', error: e, stackTrace: s);
      status.value = ProductDetailStateStatus.errorLoadProduct;
    }
  }

  Future<void> deleteProduct() async {
    try {
      status.value = ProductDetailStateStatus.loading;

      if (productModel.value != null && productModel.value!.id != null) {
        await productService.deleteProduct(productModel.value!.id!);
        status.value = ProductDetailStateStatus.deleted;
      }
    } catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      status.value = ProductDetailStateStatus.error;
      errorMessage.value = 'Erro ao deletar produto';
    }
  }
}
