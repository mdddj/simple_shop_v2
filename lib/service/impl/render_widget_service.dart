
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_tk_shop/functions/fun_type.dart';
import 'package:dd_tk_shop/service/widget_render_service.dart';
import 'package:dd_tk_shop/widget/category/category_widget.dart';
import 'package:flutter/material.dart';

class RenderWidgetService implements RenderWidgetServicAbstract{

  @override
  Widget renderCategoryWidget(List<Category> categorys, {CategorySelectd onSelectd}) {
    return CategoryWidget(onSelect: onSelectd,categorys: categorys,);
  }

}