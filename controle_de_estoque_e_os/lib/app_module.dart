import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:controle_de_estoque_e_os/modules/auth/auth_page.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_module.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance<AuthController>(AuthController()),
        Bind.instance<ApiService>(ApiService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => AuthPage()),
        ModuleRoute('/product_types', module: ProductTypeModule()),
      ];
}
