import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

import '../../enum/category_enum.dart';
import '../../functions/fun_type.dart';
import 'theme/icon.dart';
import 'theme/tab.dart';

///分类选择器组件
class CategoryWidget extends StatelessWidget {

  ///选择某个分类回调
  final CategorySelectd? onSelect;

  ///分类列表
  final List<Category>? categorys;

  /// 主题
  final CategoryRenderType renderType;

  ///构造
  const CategoryWidget(
      {Key? key,
      this.onSelect,
      this.renderType = CategoryRenderType.icon,
      this.categorys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Widget _renderWidget = Container();
        switch (renderType) {
          case CategoryRenderType.tab:
            _renderWidget = CategoryTabTheme(onSelect, categorys);
            break;
          case CategoryRenderType.icon:
            _renderWidget = CategoryIconTheme(onSelect, categorys);
            break;
        }
        return _renderWidget;
      },
    );
  }
}
