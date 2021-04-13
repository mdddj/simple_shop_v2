import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'logic.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('分类')),
      body: GetBuilder<CategoryLogic>(
        builder: (CategoryLogic controller) {
          return _renderBody();
        },
        init: CategoryLogic(),
      ),
    );
  }

  /// 主题显示内容
  Widget _renderBody() {
    final logic = CategoryLogic.instance;
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Column(
              children: leftWidgets(),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white),
            child: WaterfallFlow.builder(
              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemBuilder: (_, index) {
                final item = logic.currCategory.value.subcategories[index];
                return GestureDetector(
                  onTap: (){
                    WidgetUtil.instance.toCategoryPage(logic.currCategory.value,childId: item.subcid.toString());
                  },
                  child: Container(
                    child: Column(
                      children: [Image.network(item.scpic), Text(item.subcname)],
                    ),
                  ),
                );
              },
              itemCount: logic.currCategory.value == null
                  ? 0
                  : logic.currCategory.value.subcategories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ))
        ],
      ),
    );
  }

  /// 左边分类
  List<Widget> leftWidgets() {
    final logic = CategoryLogic.instance;
    return logic.categorys
        .map((e) => GestureDetector(
              onTap: () {
                logic.changeCurrCategory(e);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.white),
                child: Text('${e.cname}'),
              ),
            ))
        .toList();
  }
}
