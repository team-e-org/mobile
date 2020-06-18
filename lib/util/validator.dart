class Validator {
  static bool isValidEmail(String s) {
    final regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(s);
  }

  static bool isValidPassword(String s) {
    if (!RegExp(r"[a-z]").hasMatch(s)) {
      return false;
    }
    if (!RegExp(r"[A-Z]").hasMatch(s)) {
      return false;
    }
    if (!RegExp(r"\d").hasMatch(s)) {
      return false;
    }
    if (!RegExp(r"[!#%_-]").hasMatch(s)) {
      return false;
    }

    return true;
  }

  static String isValidPinTitle(String s) {
    if (s.length > 20) {
      return 'title is too long.';
    }

    return null;
  }

  static String isValidPinDescription(String s) {
    if (s.length > 280) {
      return 'description is too long.';
    }

    return null;
  }
}
