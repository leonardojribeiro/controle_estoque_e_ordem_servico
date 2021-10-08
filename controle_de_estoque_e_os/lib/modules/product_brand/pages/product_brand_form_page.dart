import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/card_widget.dart';
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
        child: CardWidget(
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (await store.create(
                        description: descriptionController.text,
                      )) {
                        Modular.to.pop();
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
