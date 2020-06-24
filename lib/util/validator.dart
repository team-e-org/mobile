import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Validator {
  static bool isValidEmail(String s) {
    final regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(s);
  }

  static bool isValidPassword(String s) {
    // TODO: サーバーのテストアカウントが修正されしだいコメントを戻す
//     if (!RegExp(r"[a-z]").hasMatch(s)) {
//       return false;
//     }
//     if (!RegExp(r"[A-Z]").hasMatch(s)) {
//       return false;
//     }
//     if (!RegExp(r"\d").hasMatch(s)) {
//       return false;
//     }
//     if (!RegExp(r"[!#%_-]").hasMatch(s)) {
//       return false;
//     }

    return true;
  }

  static String isValidPinTitle(String s) {
    // TODO(dh9489): url防ぐとかなんやらかんやら
    return null;
  }

  static String isValidPinDescription(String s) {
    // TODO(dh9489): url防ぐとかなんやらかんやら
    return null;
  }

  static String isValidPinUrl(String s) {
    // TODO(dh9489): url防ぐとかなんやらかんやら
    return null;
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
