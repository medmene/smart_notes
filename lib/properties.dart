class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

class IProperties {
  List<Pair<String, int>> getPropertyList() {}
  void setProperty(String prop, value) {}
  IProperties clone(dynamic other) {}
}

class SectionProperties implements IProperties {
  int sumIndex = -1; // has no summ
  int itemsCount = 0; // count items in a row/line
  SectionProperties(this.itemsCount, {int sumIndx = -1}) {
    sumIndex = sumIndx;
  }

  @override
  IProperties clone(dynamic other) {
    if (other is SectionProperties) {
      return SectionProperties(other.itemsCount, sumIndx: other.sumIndex);
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

// todo add page props
