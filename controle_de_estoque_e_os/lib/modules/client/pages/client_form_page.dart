import 'package:controle_de_estoque_e_os/shared/widgets/loading_widget.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({
    Key? key,
    this.clientId,
  }) : super(key: key);
  final String? clientId;

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
  bool firstRenderFired = false;
  final loading = LoadingWidget(loadingMessage: 'Carregando Cliente');

  @override
  void initState() {
    if (widget.clientId != null) {
      store.findById(id: widget.clientId ?? '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ClientStore, ApiError, ClientState>(
        onState: (context, state) {
          if (!firstRenderFired && widget.clientId != null) {
            firstRenderFired = true;
            return loading;
          }
          if (widget.clientId != null && state.client != null) {
            fullNameController.text = state.client?.fullName ?? '';
            fullAddressController.text = state.client?.fullAddress ?? '';
          }
          return ScrollViewWidget(
            appBarTitle: widget.clientId != null ? 'Editar Cliente' : 'Adicionar Cliente',
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        if (widget.clientId == null)
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
                            initialText: widget.clientId != null ? state.client?.telephone : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlutterTextField.telefone(
                            controller: whatsappController,
                            labelText: 'WhatsApp',
                            initialText: widget.clientId != null ? state.client?.whatsapp : null,
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
                            child: Text(widget.clientId != null ? 'EDITAR' : 'ADICIONAR'),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
