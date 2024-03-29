import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../constant/app_constant.dart';
import '../../controller/app_controller.dart';
import '../../controller/index_controller.dart';
import '../../service/impl/render_widget_service.dart';
import '../../widget/index/carousel.dart';
import '../../widget/index/timebuy/component.dart';
import '../../widget/product/wall_product_card.dart';
import '../taobao_activity/view.dart';
import 'waimai.dart';

///APP首页
class AppIndex extends StatefulWidget {
  const AppIndex({Key? key}) : super(key: key);

  @override
  AppIndexState createState() => AppIndexState();
}

class AppIndexState extends State<AppIndex>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoPageScaffold(
        key: logic.scaffoldKey,
        navigationBar: const CupertinoNavigationBar(
          middle: Text(kAppName),
        ),
        child: SafeArea(
          child: EasyRefresh.custom(slivers: [
            _renderCategory(),
            const Waimai(),
            _renderCarousel(),
            _renderTimeBuy(),
            _renderBody()
          ], onLoad: _nextPage),
        ));
  }

  /// 限时抢购
  Widget _renderTimeBuy() {
    return Obx(() {
      final products = logic.timeBuyProducts;
      return TimebuyComponent(
        products: products,
      ).sliverBox;
    });
  }

  ///加载更多
  Future<void> _nextPage() async {
    await AppController.instance.fetchIndexProduct();
  }

  /// 首页 - 商品列表
  Widget _renderBody() {
    return Obx(() {
      final products = AppController.instance.products;
      return SliverPadding(
        padding: const EdgeInsets.all(kDefaultPadded),
        sliver: SliverWaterfallFlow.count(
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPadded,
            crossAxisSpacing: kDefaultPadded,
            children: [
              ...products
                  .map((element) => WallProductCard(product: element))
                  .toList()
            ]),
      );
    });
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
      child: Obx(() {
        final categorys = AppController.instance.categorys;
        return Container(
          child: RenderWidgetService().renderCategoryWidget(categorys,
              onSelectd: IndexController.find.onSelected),
        );
      }),
    );
  }

  /// 轮播图
  Widget carousel() {
    return Obx(() {
      final list = IndexController.find.carousels;
      final images =
          List<String>.from(list.map((element) => element.topicImage)).toList();
      return Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: AspectRatio(
            aspectRatio: 2.53,
            child: CarouselComponent(
              images: images,
              onTap: (index) {
                final _item = IndexController.find.carousels[index];

                var view = TaobaoActivityPage(
                  activityId: _item.activityId,
                  title: _item.topicName,
                );
                Get.to(() => view);
              },
            )),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
