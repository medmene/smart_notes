class SectionSettings {
  String image = null; // has image or no
  int sumIndex = -1; // has no summ
  int itemsCount = 0; // count items in a row/line
  SectionSettings(this.itemsCount, {int sumIndx = -1}) {
    sumIndex = sumIndx;
  }
}
