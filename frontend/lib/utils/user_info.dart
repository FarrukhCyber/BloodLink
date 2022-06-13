// https://www.youtube.com/watch?v=szOllHT1S7Y

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  // static SharedPreferences _preferences;
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyPhoneNumber = 'phonenumber';
  static const _keyGender = 'gender';
  static const _keyBloodType = 'bloodtype';
  static const _keyAge = 'age';
  static const _keyDeviceId = 'deviceid';
  static const _keyIsDonor = 'isDonor';

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  static Future setPassword(String password) async =>
      await _preferences.setString(_keyPassword, password);

  static String? getPassword() => _preferences.getString(_keyPassword);

  static Future setPhoneNumber(String phonenumber) async =>
      await _preferences.setString(_keyPhoneNumber, phonenumber);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static Future setGender(String gender) async =>
      await _preferences.setString(_keyGender, gender);

  static String? getGender() => _preferences.getString(_keyGender);

  static Future setBloodType(String bloodtype) async =>
      await _preferences.setString(_keyBloodType, bloodtype);

  static String? getBloodType() => _preferences.getString(_keyBloodType);

  static Future setAge(String age) async =>
      await _preferences.setString(_keyAge, age);

  static String? getAge() => _preferences.getString(_keyAge);

  static Future setDeviceId(String deviceid) async =>
      await _preferences.setString(_keyDeviceId, deviceid);

  static Future setisDonor(String isDonor) async =>
      await _preferences.setString(_keyIsDonor, isDonor);

  static String? getDeviceId() => _preferences.getString(_keyDeviceId);

  static String? getisDonor() => _preferences.getString(_keyIsDonor);

  static Future clear() async => await _preferences.clear();
}
