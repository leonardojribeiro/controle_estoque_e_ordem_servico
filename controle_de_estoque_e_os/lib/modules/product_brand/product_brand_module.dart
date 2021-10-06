import 'package:controle_de_estoque_e_os/modules/product_brand/pages/product_brand_form_page.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/pages/product_brands_page.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductBrandModule extends Module {
  List<Bind> get binds => [
        Bind.instance<ProductBrandStore>(
          ProductBrandStore(
            repository: ProductBrandRepository(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => ProductBrandsPage()),
        ChildRoute('/add/', child: (context, args) => ProductBrandFormPage()),
      ];
}
