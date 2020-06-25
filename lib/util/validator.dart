import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Validator {
  static bool isValidEmail(String s) {
    final regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(s);
  }

  static bool isValidPassword(String s) {
    if (!RegExp(r'[a-z]').hasMatch(s)) {
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(s)) {
      return false;
    }
    if (!RegExp(r'\d').hasMatch(s)) {
      return false;
    }
    if (!RegExp(r'[!#%_-]').hasMatch(s)) {
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

  static Future<bool> isValidImageUrl(String s) async {
    try {
      final res = await http.head(s);
      return res.statusCode == 200;
    } on Exception catch (e) {
      Logger().w(e);
      return false;
    }
  }
}
