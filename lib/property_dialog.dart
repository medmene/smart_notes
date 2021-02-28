import 'package:flutter/material.dart';
import 'properties.dart';

// [Row] of settings dialog
class PropertyWidget extends StatefulWidget {
  Triple _content;
  PropertyWidgetState _state;
  bool _focus = false;

  PropertyWidget(this._content);

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
    _state = PropertyWidgetState(this._content, this._focus);
    return _state;
  }
}

class PropertyWidgetState extends State<PropertyWidget> {
  TextEditingController _textCtr = TextEditingController();
  String _propName;
  String _type;
  String _checkBoxVal;
  bool _checkedValue = false;
  bool _focus = false;

  PropertyWidgetState(Triple content, this._focus) {
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

class GroupWidget extends StatefulWidget {
  GroupWidgetState _state;
  IProperties refreshedSettings;
  String _initSelected;

  GroupWidget(this.refreshedSettings, this._initSelected);

  List<PropertyWrapper> gatherData() {
    return _state.gatherData();
  }

  @override
  createState() {
    _state = GroupWidgetState(this.refreshedSettings, this._initSelected);
    return _state;
  }
}

class GroupWidgetState extends State<GroupWidget> {
  IProperties refreshedSettings;
  List<Widget> _fields = List<Widget>();
  String _radioSwitcher = "";

  GroupWidgetState(this.refreshedSettings, this._radioSwitcher);

  List<PropertyWrapper> gatherData() {
    List<PropertyWrapper> l = List<PropertyWrapper>();
    var props = refreshedSettings.getPropertyList();

    if (_fields.isNotEmpty) {
      if (_fields.first is Row) {
        for (int i = 0; i < props.length; ++i) {
          Row row = _fields[i];
          Radio r = row.children[0];
          l.add(PropertyWrapper(true,
              grpdata: Pair(
                r.value,
                r.value == _radioSwitcher,
              )));
        }

        if (props.length < _fields.length) {
          var list = List<Triple<String, String, String>>();

          for (int i = props.length; i < _fields.length; ++i) {
            PropertyWidget w = _fields[i];
            list.add(w.getField());
          }
          l.forEach((element) {
            if (element.groupData.second) {
              element.items = list;
              return;
            }
          });
        }
      } else {
        var list = List<Triple<String, String, String>>();
        _fields.forEach((element) {
          PropertyWidget w = element;
          list.add(w.getField());
        });
        l.add(PropertyWrapper(false, itemList: list));
      }
    }
    return l;
  }

  List<Widget> getFields() {
    _fields.clear();

    var props = refreshedSettings.getPropertyList();

    bool hasGruops = false;
    props.forEach((element) {
      hasGruops = element.group ? true : hasGruops;
    });

    if (hasGruops) {
      props.forEach((grp) {
        _fields.add(Row(
          children: [
            Radio(
              value: grp.groupData.first,
              groupValue: _radioSwitcher,
              onChanged: (String value) {
                _radioSwitcher = value;

                setState(() {
                  _radioSwitcher = value;
                });
              },
            ),
            SizedBox(width: 20),
            Text(grp.groupData.first),
          ],
        ));
      });

      // set radio btn sub fields
      props.forEach((grp) {
        if (_radioSwitcher == grp.groupData.first && grp.items != null) {
          grp.items.forEach((props) {
            _fields.add(PropertyWidget(props));
          });
        }
      });

      // set focus on first
      if (_fields.length > props.length) {
        PropertyWidget w = _fields[props.length];
        w.setFocus(true);
      }
    } else {
      props.forEach((grp) {
        if (grp.items != null) {
          grp.items.forEach((props) {
            _fields.add(PropertyWidget(props));
          });
        }
      });

      if (_fields.isNotEmpty && _fields.first is PropertyWidget) {
        PropertyWidget w = _fields.first;
        w.setFocus(true);
      }
    }

    return _fields;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: getFields());
  }
}

// [Dialog] for edit setting
class PropertyDialog {
  IProperties refreshedSettings;
  Function onDone;
  GroupWidget _body;

  Widget getBody() {
    var props = refreshedSettings.getPropertyList();

    String initSelected = "";
    props.forEach((element) {
      if (element.group) {
        initSelected = element.groupData.first;
      }
    });

    _body = GroupWidget(refreshedSettings, initSelected);
    return _body;
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
              child: getBody(),
            ),
          ),
          actions: [
            RaisedButton(
              child: Text("OK"),
              onPressed: () {
                refreshedSettings.setProperty(_body.gatherData());
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
