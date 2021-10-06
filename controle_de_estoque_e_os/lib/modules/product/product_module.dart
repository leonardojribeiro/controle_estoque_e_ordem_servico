import 'package:controle_de_estoque_e_os/modules/product/pages/product_form_page.dart';
import 'package:controle_de_estoque_e_os/modules/product/pages/products_page.dart';
import 'package:controle_de_estoque_e_os/modules/product/product_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductModule extends Module {
  List<Bind> get binds => [
        Bind.instance<ProductStore>(
          ProductStore(
            repository: ProductRepository(),
            productBrandRepository: ProductBrandRepository(),
            productTypeRepository: ProductTypeRepository(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => ProductsPage()),
        ChildRoute('/add/', child: (context, args) => ProductFormPage()),
      ];
}
