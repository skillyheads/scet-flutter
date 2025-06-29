class IntSearcher {
  List<int> items;
  IntSearcher(this.items);
  int search(int key) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == key) {
        return i;
      }
    }
    return -1;
  }
}

class StringSearcher {
  List<String> items;
  StringSearcher(this.items);
  int search(String key) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == key) {
        return i;
      }
    }
    return -1;
  }
}

class Searcher<T> {
  List<T> items;
  Searcher(this.items);
  int search(T key) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == key) {
        return i;
      }
    }
    return -1;
  }
}
