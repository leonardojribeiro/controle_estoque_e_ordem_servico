import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/modules/product/widgets/change_stock_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({
    Key? key,
    this.productId,
  }) : super(key: key);
  final String? productId;

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends ModularState<ProductViewPage, ProductStore> {
  final moneyFormatter = NumberFormat('#,##0.00', 'pt_BR');
  @override
  void initState() {
    store.findById(id: widget.productId ?? '');
    super.initState();
  }

  bool firstRenderFired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductStore, ErrorDescription, ProductState>.transition(
        transition: (context, child) => AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: child,
        ),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: CustomScrollView(
                  scrollBehavior: CupertinoScrollBehavior(),
                  slivers: [
                    SliverAppBar(
                      onStretchTrigger: () async {
                        store.findById(id: widget.productId ?? '');
                      },
                      stretch: true,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [StretchMode.fadeTitle],
                        centerTitle: false,
                        title: Text(state.product?.description ?? ''),
                      ),
                      expandedHeight: 150,
                      automaticallyImplyLeading: false,
                    ),
                    SliverToBoxAdapter(
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                spacing: 8,
                                children: [
                                  Text(
                                    'Tipo: ${state.product?.productType?.description ?? ''}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (state.product?.productBrand != null)
                                    Text(
                                      'Marca: ${state.product?.productBrand?.description ?? ''}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                spacing: 8,
                                children: [
                                  Text(
                                    'Preço de custo: R\$ ${moneyFormatter.format(state.product?.costPrice ?? 0)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Preço de venda: R\$ ${moneyFormatter.format(state.product?.salePrice ?? 0)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            if (state.product?.additionalInfo != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                        child: Text(
                                      'Informações Adicionais',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                                    Text(
                                      state.product?.additionalInfo ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Text(
                                      'Informações de Estoque',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Quantidade em estoque: ${state.product?.quantityInStock ?? 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Quantidade mínima do estoque: ${state.product?.minimumQuantity ?? 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Entradas no estoque: ${state.product?.quantityIn ?? 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Saídas no estoque: ${state.product?.quantityOut ?? 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                spacing: 8,
                                children: [
                                  FloatingActionButton(
                                    tooltip: 'Adicionar',
                                    mini: true,
                                    heroTag: ChangeStockAction.add,
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => ChangeStockDialogWidget(
                                          action: ChangeStockAction.add,
                                        ),
                                      );
                                      //store.findById(id: widget.productId ?? '');
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                  FloatingActionButton(
                                    heroTag: ChangeStockAction.remove,
                                    tooltip: 'Retirar',
                                    mini: true,
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => ChangeStockDialogWidget(
                                          action: ChangeStockAction.remove,
                                        ),
                                      );
                                      //store.findById(id: widget.productId ?? '');
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                  FloatingActionButton(
                                    heroTag: ChangeStockAction.refresh,
                                    mini: true,
                                    tooltip: 'Atualizar',
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => ChangeStockDialogWidget(
                                          action: ChangeStockAction.refresh,
                                        ),
                                      );
                                      // store.findById(id: widget.productId ?? '');
                                    },
                                    child: Icon(Icons.refresh),
                                  ),
                                  FloatingActionButton(
                                    tooltip: 'Editar',
                                    mini: true,
                                    onPressed: () {
                                      Modular.to.pushNamed('/products/${state.product?.id}/update/');
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
