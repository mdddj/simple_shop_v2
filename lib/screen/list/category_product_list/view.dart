import 'package:dataoke_sdk/constant/sort.dart';
import 'package:flutter/cupertino.dart';

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
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('产品列表'),
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


  Widget _renderfilter(){
    return Icon(CupertinoIcons.sort_down);
  }

  Widget _renderMenu(CategoryProductListLogic logic){
    return PopupMenuButton<String>(
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



class CustomCupertinoActionSheet extends StatelessWidget {
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

  Widget _buildCupertinoActionSheet(BuildContext context) =>
      Container(
        alignment: Alignment.bottomCenter,
        child: CupertinoActionSheet(
          title: Text("Please chose a language"),
          message: Text('the language you use in this application.'),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Dart')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Java')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Kotlin')),
          ],
        ),
      );

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.blue,
    onPressed: () => showDialog(
        context: context,
        builder: (ctx) => _buildCupertinoActionSheet(context)),
    child: Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),
  );
}
