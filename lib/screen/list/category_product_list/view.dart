import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../../widget/product/wall_product_card.dart';
import 'logic.dart';

class CategoryProductListPage extends StatelessWidget {
  const CategoryProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductListLogic>(
      builder: (logic) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('产品列表'),
            trailing: _renderfilter(),
          ),
          child: SafeArea(
            child: EasyRefresh.custom(
              scrollController: logic.scrollController,
              controller: logic.refreshController,
              slivers: [_productList()],
              onLoad: logic.nextPage,
              onRefresh: logic.fresh,
              header: MaterialHeader(),
              footer: MaterialFooter(),
            ),
          ),
        );
      },
      init: CategoryProductListLogic(),
    );
  }

  Widget _renderfilter() {
    return const Icon(CupertinoIcons.sort_down);
  }

  //
  // Widget _renderMenu(CategoryProductListLogic logic){
  //   return PopupMenuButton<String>(
  //     itemBuilder: (_) {
  //       return [
  //         const PopupMenuItem(
  //           value: '0',
  //           child: Text('综合排序'),
  //         ),
  //         PopupMenuItem(
  //           value: DdSort.couponHighToLow,
  //           child: const Text('最高人气'),
  //         ),
  //         PopupMenuItem(
  //           value: DdSort.salesHighToLow,
  //           child: const Text('销量从高到低'),
  //         ),
  //         PopupMenuItem(
  //           value: DdSort.priceLowToHigh,
  //           child: const Text('价格从低到高'),
  //         ),
  //         PopupMenuItem(
  //           value: DdSort.priceHighToLow,
  //           child: const Text('价格从高到低'),
  //         )
  //       ];
  //     },
  //     icon: const Icon(Icons.sort),
  //     onSelected: logic.onSort,
  //   );
  // }

  Widget _productList() {
    final logic = CategoryProductListLogic.instance;
    return SliverPadding(
      sliver: SliverWaterfallFlow.count(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          children: logic.products
              .map((element) => WallProductCard(
                    product: element,
                  ))
              .toList()),
      padding: const EdgeInsets.all(12),
    );
  }
}

class CustomCupertinoActionSheet extends StatelessWidget {
  const CustomCupertinoActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoActionSheet(context),
      ],
    );
  }

  Widget _buildCupertinoActionSheet(BuildContext context) => Container(
        alignment: Alignment.bottomCenter,
        child: CupertinoActionSheet(
          title: const Text("Please chose a language"),
          message: const Text('the language you use in this application.'),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Dart')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Java')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kotlin')),
          ],
        ),
      );

  Widget _buildRaisedButton(BuildContext context) => ElevatedButton(
        onPressed: () => showDialog(
            context: context,
            builder: (ctx) => _buildCupertinoActionSheet(context)),
        child: const Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );
}
