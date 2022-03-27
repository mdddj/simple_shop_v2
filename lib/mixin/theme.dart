

import 'package:flutter/cupertino.dart';

/// 主题切换通知
class ThemeObs extends WidgetsBindingObserver {


  ///系统切换主题回调
  final VoidCallback themeChange;

  ///构造
  ThemeObs(this.themeChange);

  @override
  void didChangePlatformBrightness() {
    themeChange.call();
    super.didChangePlatformBrightness();
  }

}