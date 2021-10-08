import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';

class ChangeStockDialogWidget extends StatefulWidget {
  const ChangeStockDialogWidget({
    Key? key,
    required this.action,
  }) : super(key: key);
  final ChangeStockAction action;

  @override
  _ChangeStockDialogWidgetState createState() => _ChangeStockDialogWidgetState();
}

class _ChangeStockDialogWidgetState extends ModularState<ChangeStockDialogWidget, ProductStore> {
  final quantityController = TextEditingController();
  late String titleText;
  late String subtitleText;

  @override
  void initState() {
    titleText = widget.action == ChangeStockAction.add
        ? 'Adicionar no Estoque'
        : widget.action == ChangeStockAction.remove
            ? 'Remover no Estoque'
            : 'Atualizar Quantidade';
    subtitleText = widget.action == ChangeStockAction.add
        ? 'A quantidade em estoque será somada à quantidade informada.'
        : widget.action == ChangeStockAction.remove
            ? 'A quantidade em estoque será subtraída à quantidade informada.'
            : 'A quantidade em estoque será a informada.';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: Text(titleText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtitleText),
          FlutterTextField.numero(
            autoFocus: true,
            controller: quantityController,
            labelText: 'Quantidade de produtos',
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () async {
            final quantity = int.tryParse(quantityController.text) ?? 0;
            late bool success;
            switch (widget.action) {
              case ChangeStockAction.add:
                success = await store.addStock(
                  quantity: quantity,
                );
                break;
              case ChangeStockAction.remove:
                success = await store.removeStock(
                  quantity: quantity,
                );
                break;
              case ChangeStockAction.refresh:
                success = await store.refreshStock(
                  quantity: quantity,
                );
                break;
            }
            if (success) {
              Modular.to.pop();
            }
          },
          child: Text(
            widget.action == ChangeStockAction.add
                ? 'Adicionar'
                : widget.action == ChangeStockAction.remove
                    ? 'Remover'
                    : 'Atualizar',
          ),
        ),
      ],
    );
  }
}

enum ChangeStockAction {
  add,
  remove,
  refresh,
}
