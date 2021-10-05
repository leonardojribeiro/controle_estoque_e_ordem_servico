import 'package:controle_de_estoque_e_os/modules/product_type/pages/product_type_form_page.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/pages/product_types_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductTypeModule extends Module {
  List<Bind> get binds => [
        Bind.instance<ProductTypeStore>(
          ProductTypeStore(
            repository: ProductTypeRepository(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/add/', child: (context, args) => ProductTypeFormPage()),
        ChildRoute('/', child: (context, args) => ProductTypesPage()),
      ];
}
