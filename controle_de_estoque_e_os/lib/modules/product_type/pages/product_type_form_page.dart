import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
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
  final formKey = GlobalKey<FormState>();

  Future<void> _handleSaveButtonPressed() async {
    if (formKey.currentState?.validate() == true) {
      if (await store.create(description: descriptionController.text)) {
        Modular.to.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollViewWidget(
      appBarTitle: 'Adicionar tipo de produto',
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
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Descrição'),
                      validator: (value) => value?.isEmpty == true ? 'Campo obrigatório' : null,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _handleSaveButtonPressed,
                    child: Text('ADICIONAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
