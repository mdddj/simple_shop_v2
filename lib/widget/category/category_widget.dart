import 'package:dataoke_sdk/model/category.dart';
import '../../enum/category_enum.dart';
import '../../functions/fun_type.dart';
import 'theme/icon.dart';
import 'theme/tab.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final CategorySelectd? onSelect;
  final List<Category>? categorys;

  /// 主题
  final CategoryRenderType renderType;

  const CategoryWidget(
      {Key? key,
      this.onSelect,
      this.renderType = CategoryRenderType.ICON,
      this.categorys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Widget _renderWidget = Container();
        switch (renderType) {
          case CategoryRenderType.TAB:
            _renderWidget = CategoryTabTheme(onSelect, categorys);
            break;
          case CategoryRenderType.ICON:
            _renderWidget = CategoryIconTheme(onSelect, categorys);
            break;
        }
        return _renderWidget;
      },
    );
  }
}
