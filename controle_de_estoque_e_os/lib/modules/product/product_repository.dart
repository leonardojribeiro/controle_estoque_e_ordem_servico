import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductRepository {
  Future<List<ProductModel>> findAll() async {
    final products = await Modular.get<ApiService>().get(url: 'products');
    if (products is List) {
      return products.map((e) => ProductModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<ProductModel?> findById({required String id}) async {
    final product = await Modular.get<ApiService>().get(url: 'products/$id');
    if (product != null) {
      return ProductModel.fromMap(product);
    }
  }

  Future<dynamic> create({required ProductModel product}) async {
    return Modular.get<ApiService>().post(
      url: 'products',
      data: {
        ...product.toMap(),
        'productType': product.productType?.id,
        'productBrand': product.productBrand?.id,
      },
    );
  }

  Future<dynamic> addStock({required String id, required int quantity}) async {
    print(id + '$quantity');
    return Modular.get<ApiService>().put(
      url: 'products/$id/add_stock',
      data: {
        'quantity': quantity,
      },
    );
  }

  Future<dynamic> removeStock({required String id, required int quantity}) async {
    return Modular.get<ApiService>().put(
      url: 'products/$id/remove_stock',
      data: {
        'quantity': quantity,
      },
    );
  }

  Future<dynamic> refreshStock({required String id, required int quantity}) async {
    return Modular.get<ApiService>().put(
      url: 'products/$id/refresh_stock',
      data: {
        'quantity': quantity,
      },
    );
  }
}
