import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  const SharedPreferencesManager(this.preferenceKey);

  final String preferenceKey;

  const SharedPreferencesManager.hasSeenOnboarding()
      : this('main.onboarding.seen');

  Future<bool> getBool({bool defaultValue = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(preferenceKey) ?? defaultValue;
  }

  Future<bool> setBool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(preferenceKey, value);
  }
}
