import 'package:injectable/injectable.dart';
import 'package:product_cart/core/network/dio_client.dart';
import 'package:product_cart/modules/product/data/models/product_model.dart';
import 'package:product_cart/modules/product/data/repository/iproduct_repository.dart';

const String _url = "http://pg.dailefresh.com/WebApi/ListProductByCategoryorSubCategory_Page?Cat=FNV&Sub=FV&StoreId=1&User_id=1&R_Number=1";

@Injectable(as: IProductRepository)
class ProductRepository extends IProductRepository {
  final DioClient _dioClient;

  ProductRepository(this._dioClient);

  @override
  Future<List<ProductModel>?> fetchProducts() async {
    final result = await _dioClient.get(_url);
    if (result?.data != null) {
      return List<ProductModel>.from(result!.data["Data"].map((x) => ProductModel.fromMap(x)));
    } else {
      return null;
    }
  }
}
