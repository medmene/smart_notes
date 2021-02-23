import 'package:flutter/material.dart';
import 'sections_controller.dart';

class SkillPage extends StatefulWidget {
  @override
  createState() => SkillPageState();
}

class SkillPageState extends State<SkillPage> {
  bool _editing = false;
  bool _expanded = false;
  SectionsController _ctr = SectionsController(false);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(title: const Text('Skill Page'), actions: <Widget>[
        IconButton(
          icon: Icon(_expanded ? Icons.arrow_upward : Icons.arrow_downward),
          tooltip: 'Expand',
          onPressed: () {
            setState(() {
              _expanded = !_expanded;
              _ctr.setExpanded(_expanded);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Add new section',
          onPressed: () {
            _ctr.add();
          },
        ),
        IconButton(
          icon: Icon((_editing == true ? Icons.edit_off : Icons.edit)),
          tooltip: 'Edit',
          onPressed: () {
            setState(() {
              _editing = !_editing;
              _ctr.setEditing(_editing);
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
      _ctr,
    ]);
  }
}
