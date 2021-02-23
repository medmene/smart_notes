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
      l.add(IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Add new section',
        onPressed: () {
          _add(context);
        },
      ));
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

// class Section extends StatefulWidget {
//   int _index;
//   IPage _owner;
//   SectionProperties _settings;
//   bool _last;
//   SectionState _currentState;

//   void setIsLast(bool isLast) {
//     _last = isLast;
//     _currentState.setIsLast(isLast);
//   }

//   void setIndex(int index) {
//     _index = index;
//     _currentState.setIndex(index);
//   }

//   void refreshSelf() {
//     if (_currentState != null) {
//       _currentState.refreshSelf();
//     }
//   }

//   Section(this._owner, this._settings, this._last, this._index);
//   @override
//   createState() {
//     _currentState =
//         SectionState(this._owner, this._settings, this._last, this._index);
//     return _currentState;
//   }
// }

// // todo: add rename and remove functional
// class SectionState extends State<Section> {
//   int _index;
//   IPage _owner;
//   TextStyle _style = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
//   SectionProperties _sectionSettings;
//   bool _last;
//   bool _expanded = true;
//   SectionItemProperties _itemSettings = SectionItemProperties(1);
//   PropertyDialog _stgDialog = PropertyDialog();
//   List<SectionItem> _itemList = List<SectionItem>();

//   void setIsLast(bool isLast) {
//     _last = isLast;
//   }

//   void setIndex(int index) {
//     _index = index;
//   }

//   void refreshSelf() {
//     setState(() {});
//   }

//   void onSelectPopup(String item) {
//     if (item == "settings") {
//       _stgDialog.onDone = () {
//         _sectionSettings = _stgDialog.refreshedSettings;
//         setState(() {});
//       };
//       _stgDialog.openDialog(context, _sectionSettings);
//     } else if (item == "delete") {
//       _owner.onSectionDeleted(this._index);
//     }
//   }

//   List<Widget> _generateOutContent() {
//     List<Widget> l = List<Widget>();
//     l.add(Row(
//       children: <Widget>[
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               bool newExpanded = !_expanded;
//               setState(
//                 () {
//                   _expanded = newExpanded;
//                 },
//               );
//             },
//             child: Text(_sectionSettings.name,
//                 style: _style, textAlign: TextAlign.center),
//           ),
//         ),
//         Spacer(),
//         IconButton(
//           iconSize: 30,
//           icon: const Icon(Icons.add),
//           tooltip: 'Add content',
//           onPressed: () {
//             _stgDialog.onDone = () {
//               _itemSettings = _stgDialog.refreshedSettings;
//               _itemList.add(SectionItemRow(_itemSettings));
//               var list = _itemList;
//               setState(() {
//                 _itemList = list;
//               });
//             };
//             _stgDialog.openDialog(context, _itemSettings);
//           },
//         ),
//         PopupMenuButton(
//           icon: const Icon(Icons.more_vert),
//           itemBuilder: (BuildContext bc) {
//             return [
//               PopupMenuItem(child: Text("Settings"), value: "settings"),
//               PopupMenuItem(child: Text("Delete"), value: "delete"),
//             ];
//           },
//           onSelected: onSelectPopup,
//         ),
//       ],
//     ));
//     if (_expanded) {
//       // todo add all rows here
//       _itemList.forEach((element) {
//         l.add(element);
//       });
//     }
//     if (!_last)
//       l.add(SizedBox(
//         height: 5.0,
//         child: Center(
//           child: Container(
//               margin: EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
//               height: 3.0,
//               color: Colors.blue),
//         ),
//       ));
//     return l;
//   }

//   SectionState(this._owner, this._sectionSettings, this._last, this._index);
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: _generateOutContent());
//   }
// }
