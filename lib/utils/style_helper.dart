import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/style_model.dart';


class StyleHelper {
  FontSizeCustom fontSize = FontSizeCustom.medium;
  FontFamily fontFamily = FontFamily.font1;
  LineHeightCustom lineSpace = LineHeightCustom.medium;

  StyleHelper._();

  static final StyleHelper _instance = StyleHelper._();

  factory StyleHelper() => _instance;

  // Methods to change properties
  void changeFontSize(FontSizeCustom newSize) => fontSize = newSize;
  void changeFontFamily(FontFamily newFontFamily) => fontFamily = newFontFamily;
  void changeLineSpace(LineHeightCustom newLineSpace) => lineSpace = newLineSpace;

  // Serialize the object to JSON
  Map<String, dynamic> toJson() => {
    'fontSize': fontSize.index,
    'fontFamily': fontFamily.index,
    'lineSpace': lineSpace.index,
  };

  // Initialize StyleHelper from JSON
  void fromJson(Map<String, dynamic> json) {
    fontSize = FontSizeCustom.values[json["fontSize"] ?? FontSizeCustom.medium.index];
    lineSpace = LineHeightCustom.values[json["lineSpace"] ?? LineHeightCustom.medium.index];
    fontFamily = FontFamily.values[json["fontFamily"] ?? FontFamily.font1.index];
  }

  // Load StyleHelper settings from SharedPreferences
  static Future<StyleHelper> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final styleString = prefs.getString('styleHelper');
    final styleJson = styleString != null ? json.decode(styleString) : null;
    if (styleJson != null) {
      _instance.fromJson(styleJson);
    }
    return _instance;
  }

  // Save StyleHelper settings to SharedPreferences
  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = jsonEncode(toJson());
    await prefs.setString('styleHelper', styleJson);
  }
}
