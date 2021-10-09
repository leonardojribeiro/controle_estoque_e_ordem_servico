import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({Key? key}) : super(key: key);

  @override
  _ClientFormPageState createState() => _ClientFormPageState();
}

class _ClientFormPageState extends ModularState<ClientFormPage, ClientStore> {
  final fullNameController = TextEditingController();
  final telephoneController = FlutterTextEditingController();
  final whatsappController = FlutterTextEditingController();
  final cpfController = FlutterTextEditingController();
  final fullAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: CupertinoScrollBehavior(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Adicionar Cliente'),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: fullNameController,
                      decoration: InputDecoration(labelText: 'Nome Completo'),
                      validator: (value) => value?.isEmpty == true ? 'Campo obrigatório' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterTextField.cpfCnpj(
                      controller: cpfController,
                      labelText: 'CPF',
                      required: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterTextField.telefone(
                      controller: telephoneController,
                      labelText: 'Telefone',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterTextField.telefone(
                      controller: whatsappController,
                      labelText: 'WhatsApp',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: fullAddressController,
                      decoration: InputDecoration(labelText: 'Endereço Completo'),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          if (await store.create(
                            client: ClientModel(
                              fullName: fullNameController.text,
                              cpf: cpfController.unmaskedText,
                              fullAddress: fullAddressController.text.isNotEmpty ? fullAddressController.text : null,
                              telephone: telephoneController.unmaskedText.isNotEmpty ? telephoneController.unmaskedText : null,
                              whatsapp: whatsappController.unmaskedText.isNotEmpty ? whatsappController.unmaskedText : null,
                            ),
                          )) {
                            Modular.to.pop();
                          }
                        }
                      },
                      child: Text('Adicionar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
