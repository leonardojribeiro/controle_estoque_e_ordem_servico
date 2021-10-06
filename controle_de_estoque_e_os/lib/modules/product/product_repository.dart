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

  Future<dynamic> create({required String description}) async {
    return Modular.get<ApiService>().post(
      url: 'products',
      data: {
        'description': description,
      },
    );
  }
}
