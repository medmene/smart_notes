import 'package:flutter/material.dart';
import 'section_item.dart';
import 'section_settings.dart';

class Section extends StatefulWidget {
  State _owner; // to save internal data
  String _title;
  bool _last;
  SectionState _currentState;

  void setIsLast(bool isLast) {
    _currentState.setIsLast(isLast);
  }

  Section(this._owner, this._title, this._last);
  @override
  createState() {
    _currentState = SectionState(this._owner, this._title, this._last);
    return _currentState;
  }
}

class SectionState extends State<Section> {
  State _owner; // to save internal data
  TextStyle _style = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  String _title;
  bool _last;
  bool _expanded = true;
  SectionSettings _stgs = SectionSettings(3);
  // todo: add internal content with types
  // List<SectionItem> _itemList;

  void setIsLast(bool isLast) {
    _last = isLast;
    setState(() {});
  }

  List<Widget> _generateOutContent() {
    List<Widget> l = List<Widget>();
    l.add(Row(
      children: <Widget>[
        Expanded(
            child: GestureDetector(
                onTap: () {
                  bool newExpanded = !_expanded;
                  setState(() {
                    _expanded = newExpanded;
                  });
                },
                child:
                    Text(_title, style: _style, textAlign: TextAlign.center))),
        Spacer(),
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.add),
          tooltip: 'Add content',
          onPressed: () {},
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(child: Text("Rename"), value: "/newchat"),
              PopupMenuItem(child: Text("Delete"), value: "/settings"),
            ];
          },
        ),
      ],
    ));
    if (_expanded) l.add(SectionItemRow(_stgs)); //l.add(Text("asd"));
    if (!_last)
      l.add(SizedBox(
          height: 5.0,
          child: Center(
              child: Container(
                  margin: EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  height: 3.0,
                  color: Colors.blue))));
    // if (!_last) l.add(Divider(thickness: 2, color: Colors.blue));
    return l;
  }

  SectionState(this._owner, this._title, this._last);
  @override
  Widget build(BuildContext context) {
    return Column(children: _generateOutContent());
  }
}
