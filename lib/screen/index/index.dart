import 'package:dd_tk_shop/controller/app_controller.dart';
import 'package:dd_tk_shop/controller/index_controller.dart';
import 'package:dd_tk_shop/service/impl/render_widget_service.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:dd_tk_shop/widget/index/drawer.dart';
import 'package:dd_tk_shop/widget/list/wall_products.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class AppIndex extends StatefulWidget {
  @override
  _AppIndexState createState() => _AppIndexState();
}

class _AppIndexState extends State<AppIndex>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<IndexController>(
        builder: (logic) {
          return Scaffold(
            key: logic.scaffoldKey,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            drawer: Drawer(
              child: IndexDarwer(),
            ),
            appBar: appbar(),
            body: ListView.builder(
              itemBuilder: builder,
              itemCount: 3,
            ),
          );
        },
        init: IndexController());
  }

  Widget builder(_, index) {
    switch (index) {
      case 0:
        // 分类
        return Container(
          child: RenderWidgetService().renderCategoryWidget(
              AppController.instance.categorys,
              onSelectd: IndexController.find.onSelected),
        );
      case 1:
        // 轮播图
        return carousel();
      case 2:
        // 商品列表
        return rendItems();
      default:
        return Container();
    }
  }

  Widget carousel() {
    return Container(
      width: Get.width - 24,
      height: 200,
      child: Swiper(
        autoplay: IndexController.find.carousels.isNotEmpty,
        itemCount: IndexController.find.carousels.length,
        itemBuilder: (_, index) {
          return ExtendedImage.network(
            IndexController.find.carousels[index].topicImage,
            loadStateChanged: WidgetUtil.instance.s,
          );
        },
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          IndexController.find.scaffoldKey.currentState.openDrawer();
        },
      ),
      title: Text(
        "典典的小卖部",
      ),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
      ],
    );
  }

  Widget rendItems() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: WaterfallsFlowLayout(products: IndexController.find.indexProducts),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
