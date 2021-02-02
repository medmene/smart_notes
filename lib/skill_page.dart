import 'package:flutter/material.dart';
import 'tools.dart';

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
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(child: Text("New Chat"), value: "/newchat"),
              PopupMenuItem(
                  child: Text("New Group Chat"), value: "/new-group-chat"),
              PopupMenuItem(child: Text("Settings"), value: "/settings"),
            ];
          },
        ),
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
