
import 'package:flutter/cupertino.dart';

extension ContentExt on BuildContext {
  bool get darkMode => MediaQuery.of(this).platformBrightness == Brightness.dark;
}