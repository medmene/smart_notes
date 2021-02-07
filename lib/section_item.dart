import 'package:flutter/material.dart';
import 'section_settings.dart';

// zero type, atomic - textWidget
class TextWidget extends StatefulWidget {
  TextWidgetState _currentState;
  int _index;
  bool _last = false;

  // get text in text field
  String getText() {
    return _currentState.getText();
  }

  void setValue(String text) {
    _currentState.setValue(text);
  }

  TextWidget(this._index, {bool last = false}) {
    _last = last;
  }
  @override
  createState() {
    _currentState = TextWidgetState(this._index, this._last);
    return _currentState;
  }
}

class TextWidgetState extends State<TextWidget> {
  TextEditingController _textCtr = TextEditingController();
  TextStyle _style;
  int _index;
  bool _last = false;

  TextWidgetState(this._index, this._last) {
    _style = TextStyle(fontSize: 16); // set smth for first widget
  }

  void setValue(String text) {
    _textCtr.text = text;
  }

  String getText() {
    return _textCtr.text;
  }

  List<Widget> _getWidgets() {
    List<Widget> l = List<Widget>();
    l.add(Flexible(
        child: TextField(
            controller: _textCtr, style: _style, textAlign: TextAlign.center)));
    if (_index == 0) {
      if (!_last) l.add(Icon(Icons.dehaze));
    } else if (!_last) {
      l.add(SizedBox(width: 20));
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

// first type - row
class SectionItemRow extends SectionItem {
  SectionItemRowState _currentState;
  SectionSettings _settings;

  SectionItemRow(this._settings);
  @override
  createState() {
    _currentState = SectionItemRowState(_settings);
    return _currentState;
  }
}

class SectionItemRowState extends State<SectionItemRow> {
  SectionSettings _settings;
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
