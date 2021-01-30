import 'package:flutter/material.dart';

Widget skillPageContent() {
  return new Align(
    alignment: Alignment.bottomCenter,
    child: new ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.add_moderator, size: 32)],
    ),
  );
}
