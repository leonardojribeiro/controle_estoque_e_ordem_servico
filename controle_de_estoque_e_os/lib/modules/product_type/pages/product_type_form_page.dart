import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductTypeFormPage extends StatefulWidget {
  const ProductTypeFormPage({Key? key}) : super(key: key);

  @override
  _ProductTypeFormPageState createState() => _ProductTypeFormPageState();
}

class _ProductTypeFormPageState
    extends ModularState<ProductTypeFormPage, ProductTypeStore> {
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar tipo de produto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            OutlinedButton(
              onPressed: () async {
                if (await store.createProductType(
                    description: descriptionController.text)) {
                  Modular.to.pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}