abstract class LocalStorage {
  Future<void> setKeyValue(String key, String value);
  String? getValue(String key);
  Future<bool> removeKey(String key);
  Future<String> getAuthorizationToken();
  Future<void> setOnboardingSeen();
  Future<bool> isOnboardingSeen();
}
