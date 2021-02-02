import 'package:flutter/material.dart';

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
        IconButton(
          iconSize: 30,
          icon: Icon(Icons.more_vert),
          tooltip: 'Expand section',
          onPressed: () {},
        ),
      ],
    ));
    if (_expanded) l.add(Text("asd")); // todo: add internal content with types
    if (!_last) l.add(Divider());
    return l;
  }

  SectionState(this._owner, this._title, this._last);
  @override
  Widget build(BuildContext context) {
    return Column(children: _generateOutContent());
  }
}

class SkillPage extends StatefulWidget {
  State _owner;
  SkillPage(this._owner);
  @override
  createState() => new SkillPageState(this._owner);
}

class SkillPageState extends State<SkillPage> {
  State _owner; // to save data after use
  List<Section> _listContent = List<Section>();

  SkillPageState(this._owner);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(title: const Text('Skill Page'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Add new section',
          onPressed: () {
            // Swap random text to real Section
            var list = _listContent;
            list.forEach((element) {
              element.setIsLast(false);
            });
            list.add(Section(
                _owner, "Section" + (list.length + 1).toString(), true));
            setState(() {
              _listContent = list;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          tooltip: 'Settings',
          onPressed: () {},
        )
      ]),
      Expanded(
          child: ListView.builder(
              itemCount: _listContent.length,
              itemBuilder: (BuildContext ctxt, int indx) {
                return _listContent[indx];
              }))
    ]);
  }
}
