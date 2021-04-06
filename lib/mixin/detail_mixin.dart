import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/model/product_detail_model.dart';
import 'package:dd_tk_shop/service/impl/api_service_impl.dart';
import 'package:dd_tk_shop/util/extended_util.dart';
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
    final imageList = imageString.split(",");
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
  void copyTkl(String tklString) {
    util.copy(tklString);
    Get.dialog(AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "复制成功",
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
      content: Container(
        child: Text("$tklString"),
      ),
    ));
  }

  // 打开淘宝
  void openTb(String couponClickUrl) {
    util.openTaobao(couponClickUrl);
  }
}
