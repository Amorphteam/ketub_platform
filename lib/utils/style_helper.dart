import 'dart:convert';

import '../models/style_model.dart';

class StyleHelper {
  FontSize fontSize = FontSize.normalFontSize;
  FontFamily fontFamily = FontFamily.font1;
  LineSpace lineSpace = LineSpace.normalLineSpace;

  // Private constructor to prevent external instantiation
  StyleHelper._();

  static final StyleHelper _instance = StyleHelper._();

  factory StyleHelper() {
    return _instance;
  }

  // Methods to change properties
  void changeFontSize(FontSize newSize) {
    fontSize = newSize;
  }

  void changeFontFamily(FontFamily newFontFamily) {
    fontFamily = newFontFamily;
  }

  void changeLineSpace(LineSpace newLineSpace) {
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
      styleHelper.fontSize = FontSize.values.firstWhere(
          (e) => e.toString() == 'FontSize.${json["fontSize"]}',
      );
    } else {
      styleHelper.fontSize = FontSize.normalFontSize; // Provide a default value
    }

    if (json.containsKey("lineSpace")) {
      styleHelper.lineSpace = LineSpace.values.firstWhere(
            (e) => e.toString() == 'LineSpace.${json["lineSpace"]}',
      );
    } else {
      styleHelper.lineSpace = LineSpace.normalLineSpace; // Provide a default value
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
