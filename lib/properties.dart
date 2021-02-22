class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

class IProperties {
  List<Pair<String, dynamic>> getPropertyList() {}
  void setProperty(String prop, value) {}
  IProperties clone(dynamic other) {}
}

class SectionItemProperties implements IProperties {
  int sumIndex = -1; // has no summ
  int itemsCount = 0; // count items in a row/line
  SectionItemProperties(this.itemsCount, {int sumIndx = -1}) {
    sumIndex = sumIndx;
  }

  @override
  IProperties clone(dynamic other) {
    if (other is SectionItemProperties) {
      return SectionItemProperties(other.itemsCount, sumIndx: other.sumIndex);
    }
    return null;
  }

  @override
  List<Pair<String, int>> getPropertyList() {
    List<Pair<String, int>> l = List<Pair<String, int>>();
    l.add(Pair("Summator", sumIndex));
    l.add(Pair("Items", itemsCount));
    return l;
  }

  @override
  void setProperty(String prop, value) {
    if (prop == "Summator") {
      int sumVal = int.tryParse(value) ?? null;
      if (sumVal != null) {
        sumIndex = sumVal;
      }
    } else if (prop == "Items") {
      int itemsVal = int.tryParse(value) ?? null;
      if (itemsVal != null) {
        itemsCount = itemsVal;
      }
    }
  }
}

// todo add se props
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
  List<Pair<String, dynamic>> getPropertyList() {
    List<Pair<String, String>> l = List<Pair<String, String>>();
    l.add(Pair("Name", name));
    l.add(Pair("Max", maxCount.toString()));
    l.add(Pair("Enabled(y/n)", enabled ? "y" : "n"));
    return l;
  }

  @override
  void setProperty(String prop, value) {
    if (prop == "Name") {
      name = value.toString();
    } else if (prop == "Max") {
      int maxVal = int.tryParse(value) ?? null;
      if (maxVal != null) {
        maxCount = maxVal;
      }
    } else if (prop == "Enabled(y/n)") {
      var enblVal = value.toString();
      if (enblVal == "y") {
        enabled = true;
      } else if (enblVal == "n") {
        enabled = false;
      }
    }
  }
}
