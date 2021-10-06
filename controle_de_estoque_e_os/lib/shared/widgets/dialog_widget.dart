import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({Key? key, this.actions, this.content, this.title}) : super(key: key);

  final List<Widget>? actions;
  final Widget? content;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: actions,
      title: title,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 360),
        child: content,
      ),
    );
  }
}
