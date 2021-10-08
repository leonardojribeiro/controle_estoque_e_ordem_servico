// import 'package:controle_de_estoque_e_os/shared/contract/store_contract.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_triple/flutter_triple.dart';

// // class ListingPageWidget<Store extends StoreContract<Error extends Object, State>, State extends Object> extends StatefulWidget {
// //   const ListingPageWidget({Key? key}) : super(key: key);

// //   @override
// //   _ListingPageWidgetState<Store, State> createState() => _ListingPageWidgetState<Store, State>();
// // }

// class _ListingPageWidgetState<SS extends StoreContract, E extends Object, S extends Object> extends ModularState<ListingPageWidget, SS> {
//   @override
//   void initState() {
//     store.findAll();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ScopedBuilder<StoreContract<E, S>, E, S>.transition(
//         transition: (context, child) => AnimatedSwitcher(
//           duration: Duration(milliseconds: 400),
//           child: child,
//         ),
//         onLoading: (context) => Center(
//           child: CircularProgressIndicator(),
//         ),
//         onState: (context, state) {
//           // if (state.products == null || state.products?.isEmpty == true) {
//           //   return Center(
//           //     child: Text('Nenhum produto encontrado.'),
//           //   );
//           // }
//           return CustomScrollView(
//             scrollBehavior: CupertinoScrollBehavior(),
//             slivers: [
//               SliverAppBar(
//                 onStretchTrigger: () async {
//                   store.findAll();
//                 },
//                 stretch: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   stretchModes: [StretchMode.fadeTitle],
//                   centerTitle: false,
//                   title: Text('Produtos'),
//                 ),
//                 expandedHeight: 150,
//               ),
//               SliverToBoxAdapter(
//                 child: CustomScrollView(
//                   shrinkWrap: true,
//                   slivers: [
//                     // SliverList(
//                     //   delegate: SliverChildListDelegate(
//                     //     state.products
//                     //             ?.map(
//                     //               (product) => ListTile(
//                     //                 title: Text(product.description ?? ''),
//                     //                 subtitle: Text('Em estoque: ${product.quantityInStock ?? 0}'),
//                     //                 onTap: () {
//                     //                   Modular.to.pushNamed('/products/${product.id}/');
//                     //                 },
//                     //               ),
//                     //             )
//                     //             .toList() ??
//                     //         [],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//         onError: (context, error) => Center(
//           child: Text(error.toString()),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           Modular.to.pushNamed('/products/add/');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
