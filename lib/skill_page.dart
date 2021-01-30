import 'package:flutter/material.dart';

Widget skillPageContent() {
  return new ListView(children: [
    new Align(
      alignment: Alignment.bottomCenter,
      child: new ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[Icon(Icons.backpack, size: 32)],
      ),
    )
  ]);
}
