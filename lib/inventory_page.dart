import 'package:flutter/material.dart';

Widget inventoryPageContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Align(
        alignment: Alignment.bottomCenter,
        child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.access_alarm_outlined, size: 32)],
        ),
      )
    ],
  );
}
