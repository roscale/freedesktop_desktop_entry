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

  List<String> getStringList([String delimiter = ';']) {
    final nonEscapedSemicolons = RegExp(r'(?<!\\)' + delimiter);
    final values = split(nonEscapedSemicolons);
    if (values.last.isEmpty) {
      // Optional ending delimiter.
      values.removeLast();
    }
    // Unescape delimiters in list items.
    return values.map((e) => e.replaceAll(r'\' + delimiter, delimiter)).toList();
  }

  int? getInteger() => int.tryParse(this);
}
