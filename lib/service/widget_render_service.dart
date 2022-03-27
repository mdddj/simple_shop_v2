import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

import '../functions/fun_type.dart';

mixin RenderWidgetServicAbstract {
  Widget renderCategoryWidget(List<Category> categorys,
      {CategorySelectd? onSelectd});
}
