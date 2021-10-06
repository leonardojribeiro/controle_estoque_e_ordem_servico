import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductBrandFormPage extends StatefulWidget {
  const ProductBrandFormPage({Key? key}) : super(key: key);

  @override
  _ProductBrandFormPageState createState() => _ProductBrandFormPageState();
}

class _ProductBrandFormPageState extends ModularState<ProductBrandFormPage, ProductBrandStore> {
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Marca de produto'),
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
                if (await store.createProductBrand(
                  description: descriptionController.text,
                )) {
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
