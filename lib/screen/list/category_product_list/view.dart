import 'package:dd_tk_shop/widget/product/wall_product_card.dart';
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
          ),
          body: EasyRefresh.custom(
            slivers: [_productList()],
            onLoad: logic.nextPage,
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
