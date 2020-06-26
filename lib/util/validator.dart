class Validator {
  static bool isValidEmail(String s) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(s);
  }

  static bool isValidPassword(String s) {
    if (s == null) {
      return false;
    }
    if (s.length < 10) {
      return false;
    }
    if (!RegExp(r'[a-z]').hasMatch(s)) {
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(s)) {
      return false;
    }
    if (!RegExp(r'\d').hasMatch(s)) {
      return false;
    }

    return true;
  }

  static bool isValidBoardName(String s) {
    return s != null && s.length <= 30;
  }

  static bool isValidPinTitle(String s) {
    return s != null && s.length <= 30;
  }

  static bool isValidPinDescription(String s) {
    return s != null && s.length <= 280;
  }

  static bool isValidPinUrl(String s) {
    const urlPattern =
        r'https?://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?';
    final result = RegExp(urlPattern, caseSensitive: false);
    return result.hasMatch(s);
  }
}
