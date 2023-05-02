import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
//ako ima vrijednost -> return true, u suprotnom false
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  // kad zovemo loadThemeFromBox() key nema value, pa vraca false
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    //moramo snimiti state
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
