import 'package:flutter/material.dart';
import 'page_base.dart';
import 'sections_controller.dart';

class SkillPage extends IPage {
  dynamic _owner;

  SkillPage(this._owner);

  @override
  createState() => SkillPageState(this._owner);
}

class SkillPageState extends State<SkillPage> {
  dynamic _owner;
  bool _editing = false;
  SectionsController _ctr = SectionsController(false);

  SkillPageState(this._owner);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(title: const Text('Skill Page'), actions: <Widget>[
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
