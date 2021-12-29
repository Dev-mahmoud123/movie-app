import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class ThemeLocalDataSource {
  Future<void> updateTheme(String theme);

  Future<String> getPreferTheme();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {

  @override
  Future<String> getPreferTheme() async {
    final themeBox = await Hive.openBox("themeBox");
    return themeBox.get("preferred_theme");
  }

  @override
  Future<void> updateTheme(String theme) async {
    final themeBox = await Hive.openBox("themeBox");
    unawaited(themeBox.put("preferred_theme", theme));
  }
}