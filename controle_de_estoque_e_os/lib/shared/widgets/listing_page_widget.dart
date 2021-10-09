import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ListingPageWidget<TStore extends NotifierStore<TError, TState>, TError extends Object, TState extends Object> extends StatefulWidget {
  const ListingPageWidget({
    Key? key,
    required this.childOnState,
    required this.initialization,
  }) : super(key: key);

  final Widget Function(TState state) childOnState;
  final Function(TStore store) initialization;

  @override
  _ListingPageWidgetState<TStore, TError, TState> createState() => _ListingPageWidgetState<TStore, TError, TState>();
}

class _ListingPageWidgetState<TStore extends NotifierStore<TError, TState>, TError extends Object, TState extends Object> extends ModularState<ListingPageWidget, TStore> {
  @override
  void initState() {
    widget.initialization(store);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<TStore, TError, TState>.transition(
        store: store,
        transition: (context, child) => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: child,
        ),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) => widget.childOnState(state),
        onError: (context, error) => Center(
          child: Text(error.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Modular.to.pushNamed('/products/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
