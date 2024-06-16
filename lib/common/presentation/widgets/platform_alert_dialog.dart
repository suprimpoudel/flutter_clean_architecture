import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const PlatformAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: title,
            content: content,
            actions: actions,
          )
        : CupertinoAlertDialog(
            title: title,
            content: content,
            actions: actions,
          );
  }
}
