import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../empty/simple_empty_status_widget.dart';
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
    Widget widget = const SliverToBoxAdapter();
    switch (status) {
      case IndicatorStatus.none:
        widget = Container();
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = const LoadingMoreBysyingWidget();
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = const FullScreenWidget();
        break;
      case IndicatorStatus.empty:
        widget = const CustomEmptyWidget();
        break;
      default:
        break;
    }
    return SliverToBoxAdapter(child: widget,);
  }
}
