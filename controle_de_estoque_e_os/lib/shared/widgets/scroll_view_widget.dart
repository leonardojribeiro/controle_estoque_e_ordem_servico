import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollViewWidget extends StatelessWidget {
  const ScrollViewWidget({Key? key, required this.appBarTitle, this.onStretchTrigger, required this.slivers, this.floatingActionButton}) : super(key: key);
  final List<Widget> slivers;
  final String appBarTitle;
  final Future<void> Function()? onStretchTrigger;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: CupertinoScrollBehavior(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            stretch: true,
            onStretchTrigger: onStretchTrigger,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(appBarTitle),
            ),
          ),
          ...slivers,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
