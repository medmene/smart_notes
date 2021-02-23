import 'package:flutter/material.dart';
import 'properties.dart';

// some bug in this page

class ProreptyWidget extends StatefulWidget {
  Triple _content;
  ProreptyWidgetState _state;
  bool _focus = false;

  ProreptyWidget(this._content);

  void setFocus(bool focus) {
    _focus = focus;
    if (_state != null) {
      _state.setFocus(focus);
    }
  }

  Triple<String, String, String> getField() {
    return _state.getField();
  }

  @override
  createState() {
    _state = ProreptyWidgetState(this._content, this._focus);
    return _state;
  }
}

class ProreptyWidgetState extends State<ProreptyWidget> {
  TextEditingController _textCtr = TextEditingController();
  String _propName;
  String _type;
  String _checkBoxVal;
  bool _checkedValue = false;
  bool _focus = false;

  ProreptyWidgetState(Triple content, this._focus) {
    _type = content.third.toString();
    _propName = content.first.toString();
    if (_type == "bool") {
      _checkBoxVal = content.second.toString();
      _checkedValue = _checkBoxVal == "true";
    } else if (_type == "int" || _type == "string") {
      _textCtr.text = content.second.toString();
    }
  }

  void setFocus(bool focus) {
    _focus = focus;
  }

  Triple<String, String, String> getField() {
    if (_type == "bool") {
      return Triple(_propName, _checkBoxVal, _type);
    } else if (_type == "int" || _type == "string") {
      return Triple(_propName, _textCtr.text, _type);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget w;
    if (_type == "int" || _type == "string") {
      w = TextFormField(
        autofocus: _focus,
        controller: _textCtr,
        decoration: InputDecoration(
          labelText: _propName,
          // icon: Icon(Icons.account_box),
        ),
      );
    } else if (_type == "bool") {
      w = CheckboxListTile(
        title: Text(_propName),
        value: _checkedValue,
        onChanged: (newValue) {
          setState(() {
            _checkBoxVal = newValue ? "true" : "false";
            _checkedValue = newValue;
          });
        },
      );
    }
    return w;
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
