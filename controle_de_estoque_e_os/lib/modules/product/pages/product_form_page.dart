import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/loading_widget.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key, this.productId}) : super(key: key);
  final String? productId;

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
  bool firstRenderFired = false;
  final formKey = GlobalKey<FormState>();
  final loading = LoadingWidget(loadingMessage: 'Carregando Formulário');

  @override
  void initState() {
    if (widget.productId != null) {
      store.fetchTypesBrandsAndProductById(id: widget.productId ?? '');
    } else {
      store.fetchTypesAndBrands();
    }
    super.initState();
  }

  Future<void> _handleSaveButtonPressed() async {
    if (formKey.currentState?.validate() == true) {
      final result = widget.productId == null
          ? await store.create(
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
            )
          : await store.updateProduct(
              product: ProductModel(
                description: descriptionController.text,
                additionalInfo: additionalInfoController.text,
                productBrand: ProductBrandModel(id: productBrandId),
                productType: ProductTypeModel(id: productTypeId),
                minimumQuantity: int.tryParse(minimumQuantityController.text),
                costPrice: num.tryParse(costPriceController.unmaskedText),
                salePrice: num.tryParse(salePriceController.unmaskedText),
                id: widget.productId,
              ),
            );
      if (result == true) {
        Modular.to.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductStore, ApiError, ProductState>.transition(
        store: store,
        onLoading: (context) => loading,
        onState: (context, state) {
          if (!firstRenderFired && widget.productId != null) {
            firstRenderFired = true;
            return loading;
          }
          if (state.product != null && widget.productId != null) {
            descriptionController.text = state.product?.description ?? '';
            additionalInfoController.text = state.product?.additionalInfo ?? '';
            productBrandId = state.product?.productBrand?.id ?? '';
            productTypeId = state.product?.productType?.id ?? '';
          }
          return ScrollViewWidget(
            appBarTitle: widget.productId != null ? 'Editar Produto' : 'Adicionar Produto',
            onStretchTrigger: store.fetchTypesAndBrands,
            slivers: [
              if (state.typesAndBrands?.productTypes.isNotEmpty == true)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(labelText: 'Descrição'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String?>(
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
                              value: widget.productId != null ? state.product?.productType?.id : null,
                            ),
                          ),
                          if (state.typesAndBrands?.productBrands.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String?>(
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
                                value: widget.productId != null ? state.product?.productBrand?.id : null,
                              ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlutterTextField.moeda(
                              labelText: 'Preço de Custo',
                              controller: costPriceController,
                              initialText: widget.productId != null ? state.product?.costPrice : null,
                              min: 0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlutterTextField.moeda(
                              labelText: 'Preço de Venda',
                              controller: salePriceController,
                              initialText: widget.productId != null ? state.product?.salePrice : null,
                              min: 0,
                            ),
                          ),
                          if (widget.productId == null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlutterTextField.numero(
                                labelText: 'Quantidade em Estoque',
                                controller: quantityInStockController,
                                min: 0,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlutterTextField.numero(
                              labelText: 'Quantidade mínima em Estoque',
                              controller: minimumQuantityController,
                              initialText: widget.productId != null ? state.product?.minimumQuantity?.toInt().toString() : null,
                              min: 0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: additionalInfoController,
                              decoration: InputDecoration(labelText: 'Informações Adicionais'),
                              maxLines: 2,
                            ),
                          ),
                          Divider(),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                onPressed: _handleSaveButtonPressed,
                                child: Text(widget.productId != null ? 'EDITAR' : 'ADICIONAR'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
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
            ],
          );
        },
      ),
    );
  }
}
