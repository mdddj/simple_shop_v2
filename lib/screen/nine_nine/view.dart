import '../../widget/product/simple_card.dart';
import '../../widget/loading/simple_loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// 九块九包邮产品
class NineNinePage extends StatefulWidget {
  @override
  _NineNinePageState createState() => _NineNinePageState();
}

class _NineNinePageState extends State<NineNinePage> with SingleTickerProviderStateMixin {
  final NineNineLogic logic = Get.put(NineNineLogic());

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('九块九包邮专区'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              tabs: [
                Tab(text: '精选'),
                Tab(text: '5.9包邮'),
                Tab(text: '9.9包邮'),
                Tab(text: '19.9包邮'),
              ],
              controller: _tabController,
              isScrollable: true,
              onTap: logic.onTabChanged,
            ),
          ),
        ),
      ),
      body: Obx(() {

        if(logic.loading.value){
          return kLoadingWidget;
        }

        return ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: logic.products.length,
        );

      }),
    );
  }

  /// 商品项目卡片
  Widget _itemBuilder(_, index) {
    final product = logic.products[index];
    return SimpleCard(product: product);
  }
}
