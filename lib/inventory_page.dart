import 'package:flutter/material.dart';

Widget inventoryPageContent() {
  return new Align(
    alignment: Alignment.bottomCenter,
    child: new ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.backpack, size: 32)],
    ),
  );
}
