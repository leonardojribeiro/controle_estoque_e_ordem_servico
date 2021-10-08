import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:controle_de_estoque_e_os/modules/auth/auth_page.dart';
import 'package:controle_de_estoque_e_os/modules/auth/pages/login_page.dart';
import 'package:controle_de_estoque_e_os/modules/auth/pages/sign_up_page.dart';
import 'package:controle_de_estoque_e_os/modules/client/client_module.dart';
import 'package:controle_de_estoque_e_os/modules/establishiment/establishiment_repository.dart';
import 'package:controle_de_estoque_e_os/modules/establishiment/establishiment_store.dart';
import 'package:controle_de_estoque_e_os/modules/product/product_module.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_module.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_module.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<AuthController>(AuthController()),
        Bind.instance<ApiService>(ApiService()),
        Bind.instance<EstablishimentStore>(
          EstablishimentStore(
            repository: EstablishimentRepository(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => AuthPage()),
        ChildRoute('/sign_up/', child: (context, args) => SignUpPage()),
        ChildRoute('/login/', child: (context, args) => LoginPage()),
        ModuleRoute('/product_types', module: ProductTypeModule()),
        ModuleRoute('/product_brands', module: ProductBrandModule()),
        ModuleRoute('/products', module: ProductModule()),
        ModuleRoute('/clients', module: ClientModule()),
      ];
}
