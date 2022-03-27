import '../empty/simple_empty_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'simple_widget/full_screen_widget.dart';
import 'simple_widget/loadingmore_busying_widget.dart';

/// 自定义指示器
class CustomIndicator {
  CustomIndicator._();

  ///实例
  static CustomIndicator get instance => CustomIndicator._();

  ///私有化对象
  factory CustomIndicator() => instance;

  /// 加载更多的样式
  Widget loadingMoreStyle(BuildContext context, IndicatorStatus status) {
    var widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container();
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = LoadingMoreBysyingWidget();
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = FullScreenWidget();
        break;
      case IndicatorStatus.empty:
        widget = CustomEmptyWidget();
        break;
      default:
        break;
    }
    widget ??= Container();
    return SliverToBoxAdapter(child: widget,);
  }
}
