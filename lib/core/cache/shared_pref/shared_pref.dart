import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static  late SharedPreferences _prefs;


  ///onboarding
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool("completedOnboarding", value);
  }

  static bool getOnboardingCompleted() {
    return _prefs.getBool("completedOnboarding") ?? false;
  }

}

