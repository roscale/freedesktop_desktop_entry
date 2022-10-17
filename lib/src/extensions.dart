extension EntryValueType on String {
  bool? getBoolean() {
    switch (this) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return null;
    }
  }

  List<String> getStringList() {
    final nonEscapedSemicolons = RegExp(r'(?<!\\);');
    final values = split(nonEscapedSemicolons);
    if (values.last.isEmpty) {
      // Optional ending ';'.
      values.removeLast();
    }
    // Unescape ';' in list items.
    return values.map((e) => e.replaceAll(r'\;', ';')).toList();
  }
}
