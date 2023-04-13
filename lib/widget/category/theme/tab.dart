import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../functions/fun_type.dart';

class CategoryTabTheme extends StatelessWidget {
  final CategorySelectd? onSelect;
  final List<Category>? categorys;

  const CategoryTabTheme(this.onSelect, this.categorys, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categorys!.length,
        child: TabBar(
          tabs: categorys!.map(_buildTabItme).toList(),
          isScrollable: true,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color,
          onTap: (index) {
            final item = categorys![index];
            if (onSelect != null) onSelect!(index, item);
          },
        ));
  }

  Widget _buildTabItme(Category item) {
    return Tab(
      child: Text(item.cname.tr),
    );
  }
}
