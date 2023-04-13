import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:dd_models/models/carousel.dart';
import 'package:dd_models/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 首页控制器
class IndexController extends GetxController {
  static IndexController get find => Get.find<IndexController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// 显示商品列表
  RxList<Product> indexProducts = RxList<Product>([]);

  /// 轮播图
  RxList<Carousel> carousels = RxList<Carousel>([]);

  final RxList<Product> _timeBuyProducts = RxList<Product>([]);

  set timeBuyProducts(List<Product> values) => _timeBuyProducts.value = values;

  List<Product> get timeBuyProducts => _timeBuyProducts.toList();

  ///加载中状态
  RxBool loading = true.obs;

  @override
  void onInit() async {
    await getTimeBuyProducts();
    await getIndexShowProducts();
    await getCarousels();
    loading.value = false;
    update();
    super.onInit();
  }

  Future<void> onSelected(int index, Category category) async {
    Get.log('下标;$index , ${category.cname}');
  }

  // 加载限时抢购数据
  Future<void> getTimeBuyProducts() async {
    DdTaokeSdk.instance.getDdq(requestParamsBuilder: (RequestParams requestParams) {
      return requestParams;
    }).then((value) {
      timeBuyProducts = value?.goodsList??[];
      update();
    });
  }

  // 获取首页的商品列表
  Future<void> getIndexShowProducts() async {
    final params = ProductListParam(pageId: '1');
    await DdTaokeSdk.instance
        .getProducts(param: params, requestParamsBuilder: (RequestParams requestParams) {
          return requestParams;
    })
        .then((value) {
      if (value != null && value.list != null) {
        indexProducts.addAll(value.list!);
        update();
      }
    });
  }

  /// 获取轮播图数据
  Future<void> getCarousels() async {
    await DdTaokeSdk.instance.getCarousel().then((value) {
      value.removeWhere((element) =>
          element.sourceType == 3 ||
          element.sourceType == 4 ||
          element.sourceType == 1); // 移除京东和淘宝的活动
      carousels.addAllIf(value.isNotEmpty, value);
      update();
    });
  }
}
