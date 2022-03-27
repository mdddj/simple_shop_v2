import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

import '../../functions/fun_type.dart';
import '../../widget/category/category_widget.dart';
import '../widget_render_service.dart';

class RenderWidgetService implements RenderWidgetServicAbstract {
  @override
  Widget renderCategoryWidget(List<Category> categorys,
      {CategorySelectd? onSelectd}) {
    return CategoryWidget(
      onSelect: onSelectd,
      categorys: categorys,
    );
  }
}
