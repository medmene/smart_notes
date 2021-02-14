import 'package:flutter/material.dart';
import 'properties.dart';

// zero type, atomic - textWidget
class TextWidget extends StatefulWidget {
  TextWidgetState _currentState;
  int _index;
  bool _last = false;
  bool _summator = false;

  // get text in text field
  String getText() {
    return _currentState.getText();
  }

  void setValue(String text) {
    _currentState.setValue(text);
  }

  TextWidget(this._index, {bool last = false, bool summator = false}) {
    _last = last;
    _summator = summator;
  }
  @override
  createState() {
    _currentState = TextWidgetState(this._index, this._last, this._summator);
    return _currentState;
  }
}

class TextWidgetState extends State<TextWidget> {
  TextEditingController _textCtr = TextEditingController();
  TextStyle _style;
  int _index;
  bool _last = false;
  bool _summator = false;

  TextWidgetState(this._index, this._last, this._summator) {
    _style = TextStyle(fontSize: 22);
  }

  void setValue(String text) {
    _textCtr.text = text;
  }

  String getText() {
    return _textCtr.text;
  }

  List<Widget> _getWidgets() {
    Color c = Colors.white;
    if (_index == 0) {
      c = Colors.lightBlue[100];
    }
    if (_summator) {
      c = Colors.orange[100];
    }

    List<Widget> l = List<Widget>();
    l.add(Flexible(
      child: TextField(
        controller: _textCtr,
        style: _style,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: c,
        ),
      ),
    ));
    if (_index == 0) {
      if (!_last) l.add(SizedBox(width: 30, child: Icon(Icons.dehaze)));
    } else {
      l.add(SizedBox(width: 30));
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(child: Row(children: _getWidgets()));
  }

  @override
  void dispose() {
    _textCtr.dispose();
    super.dispose();
  }
}

/////////////////////////

// interface or base class
class SectionItem extends StatefulWidget {
  @override
  createState() {}
}

// todo: add summator
class SectionItemRow extends SectionItem {
  SectionItemRowState _currentState;
  SectionProperties _settings;

  SectionItemRow(this._settings);
  @override
  createState() {
    _currentState = SectionItemRowState(_settings);
    return _currentState;
  }
}

class SectionItemRowState extends State<SectionItemRow> {
  SectionProperties _settings;
  List<TextWidget> _row = List<TextWidget>();
  SectionItemRowState(this._settings);

  Widget _getItemsRow() {
    _row = List<TextWidget>();
    if (_settings.itemsCount == 1) {
      _row.add(TextWidget(0, last: true));
    } else {
      for (var i = 0; i < _settings.itemsCount; i++) {
        _row.add(new TextWidget(i, last: i == _settings.itemsCount - 1));
      }
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: _row),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getItemsRow();
  }
}
