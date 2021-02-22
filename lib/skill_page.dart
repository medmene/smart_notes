import 'package:flutter/material.dart';
import 'section.dart';
import 'page_base.dart';
import 'property_dialog.dart';
import 'properties.dart';

class SkillPage extends IPage {
  State _owner;
  SkillPageState _currentState;

  SkillPage(this._owner);

  @override
  void onSectionDeleted(int index) {
    _currentState.onSectionDeleted(index);
  }

  @override
  createState() {
    _currentState = SkillPageState(this);
    return _currentState;
  }
}

class SkillPageState extends State<SkillPage> {
  IPage _self;
  List<Section> _listContent = List<Section>();
  PropertyDialog _stgDialog = PropertyDialog();
  SectionProperties _settings = SectionProperties("Section");

  SkillPageState(this._self);

  void onSectionDeleted(int index) {
    if (index > -1 && index < _listContent.length) {
      var list = List<Section>();
      list.insertAll(0, _listContent);
      list.forEach((element) {
        element.setIsLast(false);
      });
      list.removeAt(index);
      for (var i = 0; i < list.length; i++) {
        list[i].setIndex(i);
        if (i == list.length - 1) {
          list[i].setIsLast(true);
        }
      }

      setState(() {
        _listContent.clear();
        _listContent.insertAll(0, list);
        _listContent.forEach((element) {
          element.refreshSelf();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(title: const Text('Skill Page'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Add new section',
          onPressed: () {
            _stgDialog.onDone = () {
              _settings = _stgDialog.refreshedSettings;
              var list = List<Section>();
              list.insertAll(0, _listContent);
              list.forEach((element) {
                element.setIsLast(false);
              });
              list.add(Section(_self, _settings, true, list.length));

              setState(() {
                _listContent.clear();
                _listContent.insertAll(0, list);
                _listContent.forEach((element) {
                  element.refreshSelf();
                });
              });
            };
            _stgDialog.openDialog(context, _settings);
          },
        ),
        IconButton(
            icon: const Icon(Icons.edit), tooltip: 'Edit', onPressed: () {}),
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
          },
        ),
      )
    ]);
  }
}
