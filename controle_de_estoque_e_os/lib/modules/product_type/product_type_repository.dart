import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductTypeRepository {
  Future<List<ProductTypeModel>> findAll() async {
    final products = await Modular.get<ApiService>().get(url: 'product_types');
    if (products is List) {
      return products.map((e) => ProductTypeModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<dynamic> create({required String description}) async {
    return Modular.get<ApiService>().post(
      url: 'product_types',
      data: {
        'description': description,
      },
    );
  }
}
