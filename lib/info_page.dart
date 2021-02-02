import 'package:flutter/material.dart';

class InfoPage {
  Column _view = new Column(
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

  Widget getContent() {
    return _view;
  }
}
