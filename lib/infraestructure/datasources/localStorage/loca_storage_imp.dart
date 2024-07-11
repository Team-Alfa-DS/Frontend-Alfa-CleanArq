import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  String? getValue(String key) => _prefs.getString(key);

  @override
  Future<bool> removeKey(String key) async => await _prefs.remove(key);

  @override
  Future<void> setKeyValue(String key, String value) async =>
      await _prefs.setString(key, value);

  @override
  Future<String> getAuthorizationToken() async {
    return _prefs.getString('appToken') ?? '';
  }

  @override
  Future<void> setOnboardingSeen() async {
    await _prefs.setBool('onboarding_seen', true);
  }

  @override
  Future<bool> isOnboardingSeen() async {
    return _prefs.getBool('onboarding_seen') ?? false;
  }
}
