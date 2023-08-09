import '../../models/product_model.dart';
import 'dart:typed_data';

abstract class ProductRepository {
  Future<List<ProductModel>> finalAll(String? name);
  Future<ProductModel> getProduct(int id);
  Future<void> save(ProductModel productModel);
  Future<String> uploadImageProduct(Uint8List file, String filename);
  Future<void> deleteProduct(int id);
}
