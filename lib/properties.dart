class Triple<T1, T2, T3> {
  final T1 first;
  final T2 second;
  final T2 third;

  Triple(this.first, this.second, this.third);
}

class IProperties {
  List<Triple<String, String, String>> getPropertyList() {}
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
  List<Triple<String, String, String>> getPropertyList() {
    List<Triple<String, String, String>> l =
        List<Triple<String, String, String>>();
    l.add(Triple("Summator", sumIndex.toString(), "int"));
    l.add(Triple("Items", itemsCount.toString(), "int"));
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
  List<Triple<String, String, String>> getPropertyList() {
    List<Triple<String, String, String>> l =
        List<Triple<String, String, String>>();
    l.add(Triple("Name", name, "string"));
    l.add(Triple("Max", maxCount.toString(), "int"));
    l.add(Triple("Enabled", enabled ? "true" : "false", "bool"));
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
    } else if (prop == "Enabled") {
      var enblVal = value.toString();
      if (enblVal == "y") {
        enabled = true;
      } else if (enblVal == "n") {
        enabled = false;
      }
    }
  }
}
