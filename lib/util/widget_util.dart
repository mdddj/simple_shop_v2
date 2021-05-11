import 'dart:convert';

import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import '../widget/loading/skeleton.dart';
import '../screen/detail/index.dart';
import '../screen/list/category_product_list/view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WidgetUtil {
  WidgetUtil._();

  static WidgetUtil get instance => WidgetUtil._();

  factory WidgetUtil() => instance;

  // 前往商品详情页面
  void detailPage({required Product product, bool isNative = false}) {
    if (!isNative) {
      Get.to(() => DetailIndex(
            product: product,
          ));
    } else {
      Navigator.push(
          Get.context!,
          MaterialPageRoute(
              builder: (c) => DetailIndex(
                    product: product,
                  )));
    }
  }

  Widget renderListTileTitle(String title) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          height: constraints.maxHeight,
          width: constraints.maxHeight * .5,
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ));
    });
  }

  Widget renderTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  /// 图片加载loading
  Widget s(ExtendedImageState state) {
    final w = state.imageWidget;
    final wd = w.width;
    final he = w.height;
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Skeleton(
          width: wd!,
          height: he!,
        );
      case LoadState.completed:
        return ExtendedRawImage(
          image: state.extendedImageInfo?.image,
        );
      case LoadState.failed:
        return GestureDetector(
          onTap: () {
            state.reLoadImage();
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(
                child: Text('图片加载失败'),
              )
            ],
          ),
        );
      default:
        return Container();
    }
  }

  /// 跳转到分类页面
  void toCategoryPage(Category? category, {String childId = ''}) {
    final box = GetStorage();
    box.write('category-load', jsonEncode(category));
    if (childId.isNotEmpty) {
      box.write('category-child', childId);
    } else {
      box.remove('category-child');
    }
    Get.to(() => CategoryProductListPage());
  }
}
