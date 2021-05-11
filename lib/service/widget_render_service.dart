
import 'package:dd_taoke_sdk/model/category.dart';
import '../functions/fun_type.dart';
import 'package:flutter/material.dart';

mixin RenderWidgetServicAbstract {

  Widget renderCategoryWidget(List<Category> categorys, {CategorySelectd? onSelectd});

}