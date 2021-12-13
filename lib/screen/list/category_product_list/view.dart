import 'package:dataoke_sdk/constant/sort.dart';

import '../../../widget/product/wall_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'logic.dart';

class CategoryProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductListLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: Text('分类'),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                      value: '0',
                      child: Text('综合排序'),
                    ),
                    PopupMenuItem(
                      value: DdSort.couponHighToLow,
                      child: Text('最高人气'),
                    ),
                    PopupMenuItem(
                      value: DdSort.salesHighToLow,
                      child: Text('销量从高到低'),
                    ),
                    PopupMenuItem(
                      value: DdSort.priceLowToHigh,
                      child: Text('价格从低到高'),
                    ),
                    PopupMenuItem(
                      value: DdSort.priceHighToLow,
                      child: Text('价格从高到低'),
                    )
                  ];
                },
                icon: Icon(Icons.sort),
                onSelected: logic.onSort,
              )
            ],
          ),
          body: EasyRefresh.custom(
            scrollController: logic.scrollController,
            controller: logic.refreshController,
            slivers: [_productList()],
            onLoad: logic.nextPage,
            onRefresh: logic.fresh,
            header: MaterialHeader(),
            footer: MaterialFooter(),
          ),
        );
      },
      init: CategoryProductListLogic(),
    );
  }

  Widget _productList() {
    final logic = CategoryProductListLogic.instance;
    return SliverPadding(
      sliver: SliverWaterfallFlow.count(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          children: logic.products
              .map((element) => Container(
                    child: WallProductCard(
                      product: element,
                    ),
                  ))
              .toList()),
      padding: EdgeInsets.all(12),
    );
  }
}
