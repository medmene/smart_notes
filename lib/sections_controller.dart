import 'package:flutter/material.dart';
import 'section.dart';
import 'property_dialog.dart';
import 'properties.dart';

class SectionsController extends StatefulWidget {
  SectionsControllerState _state;
  bool _editing = false;

  SectionsController(this._editing);

  void setExpanded(bool expandex) {
    _state.setExpanded(expandex);
  }

  void add() {
    _state.add();
  }

  void setEditing(bool editing) {
    _state.setEditing(editing);
  }

  void remove(Section item) {
    _state.remove(item);
  }

  void refresh() {
    _state.refresh();
  }

  @override
  createState() {
    _state = SectionsControllerState(this._editing);
    return _state;
  }
}

class SectionsControllerState extends State<SectionsController> {
  PropertyDialog _stgDialog = PropertyDialog();
  SectionProperties _settings = SectionProperties("Section");
  List<Section> _data = List<Section>();
  bool _editing = false;

  SectionsControllerState(this._editing);

  void setExpanded(bool expanded) {
    setState(() {
      _data.forEach((element) {
        element.expanded = expanded;
      });
    });
  }

  void setEditing(bool editing) {
    setState(() {
      _editing = editing;
      _data.forEach((element) {
        element.editingMode = _editing;
      });
    });
  }

  void add() {
    _stgDialog.onDone = () {
      setState(() {
        _settings = _stgDialog.refreshedSettings;
        _data.add(Section(widget, _settings, _editing));
        _data.forEach((element) {
          element.expanded = false;
        });
      });
    };
    _stgDialog.openDialog(context, _settings);
  }

  void remove(Section item) {
    setState(() {
      _data.removeWhere((currentItem) => item == currentItem);
    });
  }

  void refresh() {
    setState(() {});
  }

  List<ExpansionPanel> _buildPanelBody() {
    List<ExpansionPanel> l = List<ExpansionPanel>();
    _data.forEach((item) {
      l.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return item.getHeader(context);
        },
        body: item.getBody(),
        isExpanded: item.expanded,
      ));
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].expanded = !isExpanded;
        });
      },
      children: _buildPanelBody(),
    );
  }
}
