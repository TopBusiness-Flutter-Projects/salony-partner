mixin JsonParsable {
  int parseField(dynamic value) {
    if (value is int) {
      return value;
    } else {
      return int.parse(value);
    }
  }
}
