import 'package:dataoke_sdk/model/product.dart';

import '../constant/app_constant.dart';
import '../constant/color_constant.dart';
import '../model/product_detail_model.dart';
import '../service/impl/api_service_impl.dart';
import '../util/extended_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 详情页面的一些方法
mixin DetailMixin {
  final service = ApiService();
  final util = Utils();

  // 加载商品详情信息
  Future<ProductDetail> getDetail(String productId) async {
    return service.detail(id: productId);
  }

  // 加载轮播图map
  Map<String, int> getImages(String imageString) {
    var map = <String, int>{};
    final imageList = imageString.split(',');
    for (var i = 0; i < imageList.length; i++) {
      final imgurl = imageList[i];
      map[imgurl] = i + 1;
    }
    return map;
  }

  // 加载相似商品
  Future<List<Product>> loadLikeproducts(String productId) async {
    return service.getLikeProducts(productId, 10);
  }

  // 复制淘口令
  void copyTkl(String? tklString) {
    util.copy(tklString);
    Get.dialog(AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '复制成功',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$tklString'),
              SizedBox(
                height: kDefaultPadded,
              ),
              Text(
                '打开手机淘宝即可领取优惠券,请留意弹窗消息',
                style: TextStyle(color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // 打开淘宝
  void openTb(String couponClickUrl) {
    util.openTaobao(couponClickUrl);
  }
}
