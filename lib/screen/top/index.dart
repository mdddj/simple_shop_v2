import '../../controller/app_controller.dart';
import 'controller.dart';
import 'select_category.dart';
import '../../widget/list/product_list_theme1.dart';
import '../../widget/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

// 实时榜单
class TopIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopController>(
      builder: (contorller) {
        if (contorller.loading.value) return LoadingWidget();
        return Scaffold(
          appBar: AppBar(
            title: Text('排行榜单',style: TextStyle(color: Colors.black)),
          ),
          body: EasyRefresh.custom(slivers: [
            SliverToBoxAdapter(
              child: SelectCategory(
                  selected: contorller.onSelect,
                  categorys: AppController.instance.categorys),
            ),
            ProductListTheme1(products: contorller.goods)
          ], onLoad: contorller.nextPage, footer: MaterialFooter()),
        );
      },
      init: TopController(),
    );
  }
}
