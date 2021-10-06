import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductBrandRepository {
  Future<List<ProductBrandModel>> findAll() async {
    final products = await Modular.get<ApiService>().get(url: 'product_brands');
    if (products is List) {
      return products.map((e) => ProductBrandModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<dynamic> create({required String description}) async {
    return Modular.get<ApiService>().post(
      url: 'product_brands',
      data: {
        'description': description,
      },
    );
  }
}
