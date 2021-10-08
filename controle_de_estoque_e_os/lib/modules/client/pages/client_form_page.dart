import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/card_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Nome Completo'),
            ),
            FlutterTextField.cpfCnpj(
              controller: cpfController,
              labelText: 'CPF',
              required: true,
            ),
            FlutterTextField.telefone(
              controller: telephoneController,
              labelText: 'Telefone',
            ),
            FlutterTextField.telefone(
              controller: whatsappController,
              labelText: 'WhatsApp',
            ),
            TextFormField(
              controller: fullAddressController,
              decoration: InputDecoration(labelText: 'Endereço Completo'),
            ),
            OutlinedButton(
              onPressed: () async {
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
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
