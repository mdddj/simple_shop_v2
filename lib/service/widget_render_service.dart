
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_tk_shop/functions/fun_type.dart';
import 'package:flutter/material.dart';

abstract class RenderWidgetServicAbstract{

  Widget renderCategoryWidget(List<Category> categorys, {CategorySelectd onSelectd});

}