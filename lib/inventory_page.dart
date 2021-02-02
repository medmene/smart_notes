import 'package:flutter/material.dart';

class InventoryPage {
  Column _view = new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Align(
        alignment: Alignment.bottomCenter,
        child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.backpack, size: 32)],
        ),
      )
    ],
  );

  Widget getContent() {
    return _view;
  }
}
