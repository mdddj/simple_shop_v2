import 'package:auto_animated/auto_animated.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import '../../provider/app.dart';
import '../../widget/loading/simple_loadings.dart';
import '../../util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AppProvider>().loadingWithCategory;
    if (isLoading) {
      return kLoadingWidget;
    }

    final categorys = context.watch<AppProvider>().categorys;

    return Scaffold(
      appBar: AppBar(title: Text('分类')),
      body: _renderBody(categorys),
    );
  }

  /// 主题显示内容
  Widget _renderBody(List<Category> categorys) {
    final currentCategory = context.watch<AppProvider>().currentCategory;
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: Get.height - kToolbarHeight - Get.mediaQuery.padding.top,
            decoration: BoxDecoration(color: Colors.white),
            child: LiveList(itemBuilder: _leftBuilder, itemCount: categorys.length),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white),
            child: WaterfallFlow.builder(
              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemBuilder: (_, index) {
                final item = currentCategory!.subcategories![index];
                return GestureDetector(
                  onTap: () {
                    WidgetUtil.instance
                        .toCategoryPage(currentCategory, childId: item.subcid.toString());
                  },
                  child: Container(
                    child: Column(
                      children: [Image.network(item.scpic!), Text(item.subcname!)],
                    ),
                  ),
                );
              },
              itemCount: currentCategory!.subcategories!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ))
        ],
      ),
    );
  }

  Widget _leftBuilder(_, index, Animation<double> animation) {
    final item = context.watch<AppProvider>().categorys[index];
    var isCurrent = false;
    final curr = context.watch<AppProvider>().currentCategory;
    if (curr != null && curr.cid == item.cid) {
      isCurrent = true;
    }
    return GestureDetector(
      onTap: () => context.read<AppProvider>().changeCurrentCategory(item),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: isCurrent ? Colors.grey[200] : Colors.white),
        child: Text('${item.cname}'),
      ),
    );
  }
}
