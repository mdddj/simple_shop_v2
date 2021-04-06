import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/screen/detail/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetUtil {
  WidgetUtil._();

  static WidgetUtil get instance => WidgetUtil._();

  factory WidgetUtil() => instance;

  // 前往商品详情页面
  void detailPage({@required Product product, bool isNative = false}) {
    if (!isNative) {
      Get.to(() => DetailIndex(
            product: product,
          ));
    } else {
      Navigator.push(
          Get.context,
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

  // 图片加载loading
  Widget s(ExtendedImageState state) {
    final w = state.imageWidget;
    final wd = w.width;
    final he = w.height;
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return SizedBox(
          width: wd,
          height: he,
          child: Container(
            color: Colors.grey[200],
          ),
        );
        break;
      case LoadState.completed:
        return ExtendedRawImage(
          image: state.extendedImageInfo?.image,
        );
        break;
      case LoadState.failed:
        return GestureDetector(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(
                child: Text("图片加载失败"),
              )
            ],
          ),
          onTap: () {
            state.reLoadImage();
          },
        );
      default:
        return Container();
        break;
    }
  }
}
