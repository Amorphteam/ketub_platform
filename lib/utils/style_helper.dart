import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/style_model.dart';

class StyleHelper {
  FontSizeCustom fontSize = FontSizeCustom.medium;
  FontFamily fontFamily = FontFamily.font1;
  LineHeightCustom lineSpace = LineHeightCustom.medium;

  // Private constructor to prevent external instantiation
  StyleHelper._();

  static final StyleHelper _instance = StyleHelper._();

  factory StyleHelper() {
    return _instance;
  }


  // Methods to change properties
  void changeFontSize(FontSizeCustom newSize) {
    fontSize = newSize;
  }

  void changeFontFamily(FontFamily newFontFamily) {
    fontFamily = newFontFamily;
  }

  void changeLineSpace(LineHeightCustom newLineSpace) {
    lineSpace = newLineSpace;
  }

  // Serialize the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize.name.toString(),
      'fontFamily': fontFamily.name.toString(),
      'lineSpace': lineSpace.name.toString(),
    };
  }

  // Create an object from a JSON representation
  factory StyleHelper.fromJson(Map<String, dynamic> json) {
    final styleHelper = StyleHelper();

    if (json.containsKey("fontSize")) {
      styleHelper.fontSize = FontSizeCustom.values.firstWhere(
          (e) => e.toString() == 'FontSize.${json["fontSize"]}',
      );
    } else {
      styleHelper.fontSize = FontSizeCustom.medium;
    }

    if (json.containsKey("lineSpace")) {
      styleHelper.lineSpace = LineHeightCustom.values.firstWhere(
            (e) => e.toString() == 'LineSpace.${json["lineSpace"]}',
      );
    } else {
      styleHelper.lineSpace = LineHeightCustom.medium;
    }


    if (json.containsKey("fontFamily")) {
      styleHelper.fontFamily = FontFamily.values.firstWhere(
            (e) => e.toString() == 'FontFamily.${json["fontFamily"]}',
      );
    } else {
      styleHelper.fontFamily = FontFamily.font1; // Provide a default value
    }
    return styleHelper;
  }
}
