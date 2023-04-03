extension ListUtils on List {
  E? firstWhereOrNull<E>(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
