// Utils
class Triple<T1, T2, T3> {
  final T1 first;
  final T2 second;
  final T2 third;

  Triple(this.first, this.second, this.third);
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}
/////////////////////

// Wrapper for managing groups of widget
class PropertyWrapper {
  bool group = false;
  Pair<String, bool> groupData;
  List<Triple<String, String, String>> items;

  PropertyWrapper(this.group,
      {Pair<String, bool> grpdata,
      List<Triple<String, String, String>> itemList}) {
    groupData = grpdata;
    items = itemList;
  }
}

// Interface for section items
class IProperties {
  List<PropertyWrapper> getPropertyList() {}
  void setProperty(List<PropertyWrapper> newData) {}
  IProperties clone(dynamic other) {}
}

// [Section item] properties
enum ItemType { image, row, progressbar }

class SectionItemProperties implements IProperties {
  ItemType type = ItemType.row;
  int sumIndex = -1; // has no summ
  int itemsCount = 0; // count items in a row/line

  @override
  IProperties clone(dynamic other) {
    if (other is SectionItemProperties) {
      var n = SectionItemProperties();
      n.itemsCount = other.itemsCount;
      n.sumIndex = other.sumIndex;
      n.type = other.type;
      return n;
    }
    return null;
  }

  @override
  List<PropertyWrapper> getPropertyList() {
    List<PropertyWrapper> l = List<PropertyWrapper>();
    l.add(PropertyWrapper(
      true,
      grpdata: Pair("Image", type == ItemType.image),
    ));

    l.add(PropertyWrapper(
      true,
      grpdata: Pair("Progressbar", type == ItemType.progressbar),
    ));

    l.add(PropertyWrapper(
      true,
      grpdata: Pair("Row", type == ItemType.row),
      itemList: [
        Triple("Summator", sumIndex.toString(), "int"),
        Triple("Items", itemsCount.toString(), "int"),
      ],
    ));
    return l;
  }

  @override
  void setProperty(List<PropertyWrapper> newData) {
    newData.forEach((grp) {
      if (grp.groupData.first == "Row" && grp.groupData.second) {
        type = ItemType.row;
        grp.items.forEach((prop) {
          if (prop.first == "Summator") {
            int sumVal = int.tryParse(prop.second) ?? null;
            if (sumVal != null) {
              sumIndex = sumVal;
            }
          } else if (prop.first == "Items") {
            int itemsVal = int.tryParse(prop.second) ?? null;
            if (itemsVal != null) {
              itemsCount = itemsVal;
            }
          }
        });
      } else if (grp.groupData.first == "Progressbar" && grp.groupData.second) {
        type = ItemType.progressbar;
      } else if (grp.groupData.first == "Image" && grp.groupData.second) {
        type = ItemType.image;
      }
    });
  }
}

// [Section] properties
class SectionProperties implements IProperties {
  String name = "Section";
  int maxCount = -1;
  bool enabled = true;

  SectionProperties(this.name, {int max = -1, bool active = true}) {
    maxCount = max;
    enabled = active;
  }

  @override
  IProperties clone(dynamic other) {
    if (other is SectionProperties) {
      return SectionProperties(other.name,
          max: other.maxCount, active: other.enabled);
    }
    return null;
  }

  @override
  List<PropertyWrapper> getPropertyList() {
    List<PropertyWrapper> l = List<PropertyWrapper>();
    l.add(PropertyWrapper(
      false,
      itemList: [
        Triple("Name", name, "string"),
        Triple("Max", maxCount.toString(), "int"),
        Triple("Enabled", enabled ? "true" : "false", "bool")
      ],
    ));
    return l;
  }

  @override
  void setProperty(List<PropertyWrapper> newData) {
    if (newData.first != null) {
      newData.first.items.forEach((prop) {
        if (prop.first == "Name") {
          name = prop.second;
        } else if (prop.first == "Max") {
          int maxVal = int.tryParse(prop.second) ?? null;
          if (maxVal != null) {
            maxCount = maxVal;
          }
        } else if (prop.first == "Enabled") {
          var enblVal = prop.second.toString();
          if (enblVal == "y") {
            enabled = true;
          } else if (enblVal == "n") {
            enabled = false;
          }
        }
      });
    }
  }
}
