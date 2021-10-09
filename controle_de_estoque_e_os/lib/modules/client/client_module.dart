import 'package:controle_de_estoque_e_os/modules/client/client_repository.dart';
import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
import 'package:controle_de_estoque_e_os/modules/client/pages/client_form_page.dart';
import 'package:controle_de_estoque_e_os/modules/client/pages/client_view_page.dart';
import 'package:controle_de_estoque_e_os/modules/client/pages/clients_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ClientModule extends Module {
  List<Bind> get binds => [
        Bind.instance<ClientStore>(
          ClientStore(
            repository: ClientRepository(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/add/', child: (context, args) => ClientFormPage()),
        ChildRoute('/', child: (context, args) => ClientsPage()),
        ChildRoute('/:id/', child: (context, args) => ClientViewPage(clientId: args.params['id'])),
      ];
}
