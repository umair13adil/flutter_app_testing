
class KeyHelper {
  static final KeyHelper _singleton = new KeyHelper._internal();

  factory KeyHelper() {
    return _singleton;
  }

  KeyHelper._internal();

  static String getStringKeyForListItem(String type, int index) {
    return type + index.toString();
  }
}