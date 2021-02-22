import 'package:flutter/material.dart';
import 'properties.dart';

// some bug in this page

class ProreptyWidget extends StatelessWidget {
  TextEditingController _textCtr = TextEditingController();
  String _propName;
  bool _focus = false;

  ProreptyWidget(Pair content) {
    _textCtr.text = content.second.toString();
    _propName = content.first.toString();
  }

  void setFocus(bool focus) {
    _focus = focus;
  }

  Pair<String, dynamic> getField() {
    return Pair(_propName, _textCtr.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: _focus,
      controller: _textCtr,
      decoration: InputDecoration(
        labelText: _propName,
        icon: Icon(Icons.account_box),
      ),
    );
  }
}

class PropertyDialog {
  IProperties refreshedSettings;
  Function onDone;
  List<ProreptyWidget> _fields;

  List<ProreptyWidget> getFields() {
    _fields = List<ProreptyWidget>();
    var props = refreshedSettings.getPropertyList();
    props.forEach((element) {
      _fields.add(ProreptyWidget(element));
    });
    if (_fields.isNotEmpty) {
      _fields.first.setFocus(true);
    }
    return _fields;
  }

  void openDialog(context, IProperties stng) {
    refreshedSettings = stng.clone(stng);
    BuildContext dialogContext;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          scrollable: true,
          title: Text('Property'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(children: getFields()),
            ),
          ),
          actions: [
            RaisedButton(
              child: Text("OK"),
              onPressed: () {
                _fields.forEach((element) {
                  var field = element.getField();
                  refreshedSettings.setProperty(field.first, field.second);
                });
                Navigator.pop(dialogContext);
                onDone();
              },
            )
          ],
        );
      },
    );
  }
}
