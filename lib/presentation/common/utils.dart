bool isNumeric(String string) {
// Null or empty string is not a number
  if (string.isEmpty) {
    return false;
  }

  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }

  return true;
}
