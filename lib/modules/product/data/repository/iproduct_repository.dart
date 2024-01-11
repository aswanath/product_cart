import 'package:product_cart/modules/product/data/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>?> fetchProducts();
}
