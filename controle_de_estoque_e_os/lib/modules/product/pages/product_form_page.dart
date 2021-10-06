import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ModularState<ProductFormPage, ProductStore> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    store.fetchTypesAndBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      body: ScopedBuilder(
        store: store,
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) => SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              OutlinedButton(
                onPressed: () async {
                  if (await store.createProduct(
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
      ),
    );
  }
}
