import 'package:flutter/material.dart';
import 'properties.dart';

// zero type, atomic - textWidget
class TextWidget extends StatelessWidget {
  SectionItemRow _owner;
  TextEditingController _textCtr = TextEditingController();
  TextStyle _style;
  int _index;
  bool _last = false;
  bool _summator = false;

  TextWidget(this._owner, this._index,
      {bool last = false, bool summator = false, bool initByZero = false}) {
    _last = last;
    _summator = summator;
    _style = TextStyle(fontSize: 22);
    if (initByZero) {
      _textCtr.text = "0";
    }
  }

  bool isSummator() {
    return _summator;
  }

  void _onChanged(String) {
    _owner.onChanged();
  }

  void setText(String text) {
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
        onChanged: _onChanged,
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
  }
}

/////////////////////////

// interface or base class
// other items: image, progressbar
class SectionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class SectionItemRow extends SectionItem {
  SectionItemProperties _settings;
  List<TextWidget> _row = List<TextWidget>();
  SectionItemRow(this._settings);

  void onChanged() {
    int sum = 0;
    _row.forEach((element) {
      if (!element.isSummator()) {
        int val = int.tryParse(element.getText());
        if (val != null) {
          sum += val;
        } else {
          sum += 0;
        }
      }
    });
    if (_settings.sumIndex != -1) {
      _row[_settings.sumIndex].setText(sum.toString());
    }
  }

  Widget _getItemsRow() {
    if (_row.isEmpty) {
      if (_settings.itemsCount == 1) {
        _row.add(TextWidget(this, 0, last: true));
      } else {
        for (var i = 0; i < _settings.itemsCount; i++) {
          _row.add(new TextWidget(this, i,
              last: i == _settings.itemsCount - 1,
              summator: i == _settings.sumIndex,
              initByZero: _settings.sumIndex != -1));
        }
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
