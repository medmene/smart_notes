import 'package:flutter/material.dart';
import 'section_item.dart';
import 'properties.dart';
import 'property_dialog.dart';
import 'sections_controller.dart';

class Section {
  PropertyDialog _stgDialog = PropertyDialog();
  SectionProperties _sectionSettings;
  bool expanded = false;
  bool editingMode = false;
  List<SectionItem> _itemList = List<SectionItem>();
  SectionItemProperties _itemSettings = SectionItemProperties(1);
  SectionsController _ctr;

  Section(this._ctr, this._sectionSettings, this.editingMode);

  void _add(context) {
    _stgDialog.onDone = () {
      _itemSettings = _stgDialog.refreshedSettings;
      _itemList.add(SectionItemRow(_itemSettings));
      _ctr.refresh();
    };
    _stgDialog.openDialog(context, _itemSettings);
  }

  void onSelectPopup(context, String item) {
    if (item == "settings") {
      _stgDialog.onDone = () {
        _sectionSettings = _stgDialog.refreshedSettings;
        _ctr.refresh();
      };
      _stgDialog.openDialog(context, _sectionSettings);
    } else if (item == "delete") {
      _ctr.remove(this);
    }
  }

  Widget getHeader(context) {
    List<Widget> l = List<Widget>();
    l.add(SizedBox(width: 20));
    l.add(Text(_sectionSettings.name, style: TextStyle(fontSize: 20)));
    if (editingMode) {
      l.add(Spacer());
      if (_sectionSettings.maxCount == -1 ||
          _itemList.length < _sectionSettings.maxCount) {
        l.add(IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Add new section',
          onPressed: () {
            _add(context);
          },
        ));
      }
      l.add(PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(child: Text("Settings"), value: "settings"),
            PopupMenuItem(child: Text("Delete"), value: "delete"),
          ];
        },
        onSelected: (String item) {
          onSelectPopup(context, item);
        },
      ));
    }
    return Row(children: l);
  }

  Widget getBody() {
    return Column(children: _itemList);
  }
}
