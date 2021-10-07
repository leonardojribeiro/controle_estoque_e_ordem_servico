import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_text_field/flutter_text_field.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ModularState<ProductFormPage, ProductStore> {
  final descriptionController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final quantityInStockController = TextEditingController();
  final minimumQuantityController = TextEditingController();
  final costPriceController = FlutterTextEditingController();
  final salePriceController = FlutterTextEditingController();
  String productTypeId = '';
  String productBrandId = '';

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
      body: ScopedBuilder<ProductStore, ErrorDescription, ProductState>(
        store: store,
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          if (state.typesAndBrands?.productTypes.isEmpty == true) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Não encontramos nenhum tipo de produto cadastrado.\nPara continuar, você precisa adicionar pelo menos um tipo de produto para vinculá-lo aos seus produtos.'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              await Modular.to.pushNamed('/product_types/');
                              store.fetchTypesAndBrands();
                            },
                            child: Text('Ir para tipos de produto'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(labelText: 'Descrição'),
                        ),
                        DropdownButtonFormField<String?>(
                          decoration: InputDecoration(labelText: 'Tipo do Produto'),
                          onChanged: (value) => productTypeId = value ?? '',
                          items: state.typesAndBrands?.productTypes
                                  .map(
                                    (productType) => DropdownMenuItem(
                                      value: productType.id,
                                      child: Text(
                                        productType.description ?? '',
                                      ),
                                    ),
                                  )
                                  .toList() ??
                              [],
                        ),
                        if (state.typesAndBrands?.productBrands.isNotEmpty == true)
                          DropdownButtonFormField<String?>(
                            decoration: InputDecoration(labelText: 'Marca do Produto'),
                            onChanged: (value) => productBrandId = value ?? '',
                            items: state.typesAndBrands?.productBrands
                                    .map(
                                      (productBrand) => DropdownMenuItem(
                                        value: productBrand.id,
                                        child: Text(
                                          productBrand.description ?? '',
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                [],
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Não encontramos nenhuma marca cadastrada.\nVocê pode continuar neste cadastro caso não deseje vincular este produto a uma.'),
                                Center(
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      await Modular.to.pushNamed('/product_brands/');
                                      store.fetchTypesAndBrands();
                                    },
                                    child: Text('Ir para marcas'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        FlutterTextField.moeda(
                          labelText: 'Preço de Custo',
                          controller: costPriceController,
                          min: 0,
                        ),
                        FlutterTextField.moeda(
                          labelText: 'Preço de Venda',
                          controller: salePriceController,
                          min: 0,
                        ),
                        FlutterTextField.numero(
                          labelText: 'Quantidade em Estoque',
                          controller: quantityInStockController,
                          min: 0,
                        ),
                        FlutterTextField.numero(
                          labelText: 'Quantidade mínima em Estoque',
                          controller: minimumQuantityController,
                          min: 0,
                        ),
                        TextFormField(
                          controller: additionalInfoController,
                          decoration: InputDecoration(labelText: 'Informações Adicionais'),
                          maxLines: 2,
                        ),
                        Divider(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () async {
                                if (await store.create(
                                  product: ProductModel(
                                    description: descriptionController.text,
                                    additionalInfo: additionalInfoController.text,
                                    productBrand: ProductBrandModel(id: productBrandId),
                                    productType: ProductTypeModel(id: productTypeId),
                                    minimumQuantity: int.tryParse(minimumQuantityController.text),
                                    costPrice: num.tryParse(costPriceController.unmaskedText),
                                    salePrice: num.tryParse(salePriceController.unmaskedText),
                                    quantityInStock: int.tryParse(quantityInStockController.text),
                                  ),
                                )) {
                                  Modular.to.pop();
                                }
                              },
                              child: Text('Adicionar Produto'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
