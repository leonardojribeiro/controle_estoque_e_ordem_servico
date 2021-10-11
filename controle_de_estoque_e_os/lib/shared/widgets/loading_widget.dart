import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.loadingMessage}) : super(key: key);
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return ScrollViewWidget(
      appBarTitle: 'Aguarde',
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(),
              Column(
                children: [
                  Center(
                    child: Text(
                      loadingMessage,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
