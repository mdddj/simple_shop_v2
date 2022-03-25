import '../taobao_activity/view.dart';

import '../../constant/app_constant.dart';

import '../../components/product_list/products_list_components.dart';
import '../../controller/app_controller.dart';
import '../../controller/index_controller.dart';
import '../../service/impl/render_widget_service.dart';
import '../../widget/index/carousel.dart';
import '../../widget/index/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'waimai.dart';

class AppIndex extends StatefulWidget {
  @override
  _AppIndexState createState() => _AppIndexState();
}

class _AppIndexState extends State<AppIndex> with AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: logic.scaffoldKey,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      drawer: Drawer(
        child: IndexDarwer(),
      ),
      body: NestedScrollView(
        body: _renderBody(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [_renderAppbar(),_renderCategory(), SliverToBoxAdapter(child: Waimai()), _renderCarousel()];
        },
      ),
    );
  }

  /// 首页 - 商品列表
  Widget _renderBody() {
    return ProductListComponents();
  }

  /// 首页 - 轮播图
  Widget _renderCarousel() {
    return SliverToBoxAdapter(
      child: carousel(),
    );
  }

  /// 首页 - 主分类
  Widget _renderCategory() {
    return SliverToBoxAdapter(
      child: Container(
        child: RenderWidgetService().renderCategoryWidget(AppController.instance.categorys,
            onSelectd: IndexController.find.onSelected),
      ),
    );
  }

  /// 首页 - 导航条
  Widget _renderAppbar() {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          IndexController.find.scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(
        '典典的小卖部',
      ),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
      ],
      pinned: true,
    );
  }

  /// 轮播图
  Widget carousel() {
    return Obx(() {
      final list = IndexController.find.carousels.value;
      final images = List<String>.from(list.map((element) => element.topicImage)).toList();
      return Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadded),
          child: CarouselComponent(
            images: images,
            onTap: (index) {
              final _item = IndexController.find.carousels[index];
              if (_item.sourceType != null) {
                /// 调用淘宝活动
                print(_item.activityId);
                var view = TaobaoActivityPage(
                  activityId: '${_item.activityId}',
                  title: '${_item.topicName}',
                );
                Get.to(() => view);
              }
            },
          ));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
