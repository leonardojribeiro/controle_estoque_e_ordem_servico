import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/card_widget.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductTypeFormPage extends StatefulWidget {
  const ProductTypeFormPage({Key? key}) : super(key: key);

  @override
  _ProductTypeFormPageState createState() => _ProductTypeFormPageState();
}

class _ProductTypeFormPageState extends ModularState<ProductTypeFormPage, ProductTypeStore> {
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollViewWidget(
      appBarTitle: 'Adicionar tipo de produto',
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              OutlinedButton(
                onPressed: () async {
                  if (await store.create(description: descriptionController.text)) {
                    Modular.to.pop();
                  }
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
