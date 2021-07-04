import 'dart:convert';

class StringsUtil {
  static String toB64(String value) {
    var bytes = utf8.encode(value);
    return base64.encode(bytes);
  }
  static String fromB64(String value) {
    var bytes = base64.decode(value);
    return utf8.decode(bytes);
  }
}