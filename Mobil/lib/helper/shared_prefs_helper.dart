import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences _prefs;

  static const KEY_TOKEN = "key_token";
  static const KEY_USER_ID = "key_userid";
  static const KEY_MAIL = "key_mail";
  static const KEY_MAIL_REMEMBER_ME = "key_mail_remember_me";
  static const KEY_PASSWORD_REMEMBER_ME = "key_password_remember_me";
  static const KEY_PASSWORD = "key_password";
  static const KEY_FIRST_NAME = "key_firstname";
  static const KEY_LAST_NAME = "key_lastname";
  static const KEY_IMAGE = "key_image";
  static const KEY_PHONE = "key_lastname";
  static const KEY_PLAYER_ID = "key_player_id";
  static const KEY_IMEI = "key_imei";

  // Singleton shared pref object
  static initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<void> saveToken(String token) async{
    return _prefs.setString(KEY_TOKEN, token);
  }

  static Future<void> saveMail(String mail) async {
    return _prefs.setString(KEY_MAIL, mail);
  }

  static Future<void> saveMailForRememberMe(String mail) async {
    return _prefs.setString(KEY_MAIL_REMEMBER_ME, mail);
  }

  static Future<void> savePassword(String password) async {
    return _prefs.setString(KEY_PASSWORD, password);
  }

  static Future<void> savePasswordForRememberMe(String password) async {
    return _prefs.setString(KEY_PASSWORD_REMEMBER_ME, password);
  }

  static Future<void> saveUserId(int userId) async {
    return _prefs.setInt(KEY_USER_ID, userId);
  }

  static Future<void> saveFirstName(String firstName) async {
    return _prefs.setString(KEY_FIRST_NAME, firstName);
  }

  static Future<void> saveLastName(String lastName) async {
    return _prefs.setString(KEY_LAST_NAME, lastName);
  }

  static Future<void> saveImage(String image) async {
    return _prefs.setString(KEY_IMAGE, image);
  }

  static Future<void> savePhone(String phone) async {
    return _prefs.setString(KEY_PHONE, phone);
  }

  static Future<void> savePlayerId(String playerId) async {
    return _prefs.setString(KEY_PLAYER_ID, playerId);
  }

  static Future<void> saveImei(String imei) async {
    return _prefs.setString(KEY_IMEI, imei);
  }

  static String get getToken => _prefs.getString(KEY_TOKEN) ?? null;
  static int get getUserId => _prefs.getInt(KEY_USER_ID) ?? null;
  static String get getFirstName => _prefs.getString(KEY_FIRST_NAME) ?? null;
  static String get getLastName => _prefs.getString(KEY_LAST_NAME) ?? null;
  static String get getImage => _prefs.getString(KEY_IMAGE) ?? null;
  static String get getPhone => _prefs.getString(KEY_PHONE) ?? null;
  static String get getMail => _prefs.get(KEY_MAIL) ?? null;
  static String get getMailForRememberMe => _prefs.get(KEY_MAIL_REMEMBER_ME) ?? null;
  static String get getPassword => _prefs.get(KEY_PASSWORD) ?? null;
  static String get getPasswordForRememberMe => _prefs.get(KEY_PASSWORD_REMEMBER_ME) ?? null;
  static String get getPlayerId => _prefs.getString(KEY_PLAYER_ID) ?? null;
  static String get getImei => _prefs.getString(KEY_IMEI) ?? null;
}