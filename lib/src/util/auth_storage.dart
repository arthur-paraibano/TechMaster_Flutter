import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _tokenKey = 'auth_token';
  static const String _idKey = 'user_id';
  static const String _nameKey = 'user_name';
  static const String _emailKey = 'user_email';
  static const String _profileKey = 'user_profile';

  static Future<void> saveLoginData({
    required String token,
    required int id,
    required String name,
    required String email,
    required String profile,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_idKey, id);
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_profileKey, profile);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_idKey);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileKey);
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_idKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_profileKey);
  }
}
