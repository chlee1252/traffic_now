import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> closeButtonDialog({BuildContext context, String title, String content}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => new CupertinoAlertDialog(
      title: title != null ? Text(title) : Text(""),
      content: content != null ? Text(content) : Text(""),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}