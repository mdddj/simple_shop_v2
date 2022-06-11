import 'package:auto_animated/auto_animated.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../constant/app_constant.dart';
import '../../provider/app.dart';
import '../../util/widget_util.dart';
import '../../widget/loading/simple_loadings.dart';

///分类页面
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

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

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('分类'),
      ),
      child: SafeArea(child: _renderBody(categorys,"")),
    );
  }

  /// 主题显示内容
  Widget _renderBody(List<Category> categorys,String str) {
    final currentCategory = context.watch<AppProvider>().currentCategory;
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height:
                Get.height - kToolbarHeight - context.mediaQuery.padding.top,
            child: LiveList(
                itemBuilder: _leftBuilder, itemCount: categorys.length),
          ),
          Expanded(
              child: WaterfallFlow.builder(
            padding: const EdgeInsets.all(kDefaultPadded),
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
            itemBuilder: (_, index) {
              final item = currentCategory!.subcategories![index];
              return GestureDetector(
                onTap: () {
                  WidgetUtil.instance.toCategoryPage(currentCategory,
                      childId: item.subcid.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadded / 2),
                  child: Column(
                    children: [
                      ClipRRect(
                        child: AspectRatio(
                            child: Image.network(item.scpic!),aspectRatio: 1,),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      const SizedBox(width: 1,),
                      Text(item.subcname!)
                    ],
                  ),
                ),
              );
            },
            itemCount: currentCategory!.subcategories!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadded),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadded),
          decoration:
              BoxDecoration(color: isCurrent ? context.theme.primaryColor : null,
              borderRadius: BorderRadius.circular(8)
              ),
          child: Text('${item.cname}'),
        ),
      ),
    );
  }
}
