import 'package:dd_taoke_sdk/model/category.dart';
import '../../../functions/fun_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTabTheme extends StatelessWidget{

  final CategorySelectd? onSelect;
  final List<Category>? categorys;

  CategoryTabTheme(this.onSelect, this.categorys);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categorys!.length,
        child: TabBar(
          tabs: categorys!.map(_buildTabItme).toList(),
          isScrollable: true,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color,
          onTap: (index) {
            final item = categorys![index];
            if (onSelect != null) onSelect!(index, item);
          },
        ));
  }

  Widget _buildTabItme(Category item) {
    return Tab(
      child: Text('${item.cname!.tr}'),
    );
  }

}