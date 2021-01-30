import 'package:flutter/material.dart';

Widget infoPageContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Align(
        alignment: Alignment.bottomCenter,
        child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.account_circle, size: 32)],
        ),
      )
    ],
  );
}
