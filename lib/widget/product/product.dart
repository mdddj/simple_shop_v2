import 'package:dd_taoke_sdk/model/product.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flustars/flustars.dart' hide WidgetUtil;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 商品卡片布局
class ProductLayout extends StatelessWidget {
  final Product product;

  const ProductLayout({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, left: 4),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [renderMainImage(), renderPrice(), renderDiscountPrice()],
      ),
    );
  }

  // 原价
  Widget renderDiscountPrice() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        '¥ ${product.originalPrice}',
        style: Get.textTheme.bodyText1!.copyWith(
            color: Colors.grey, decoration: TextDecoration.lineThrough,fontSize: 12),
      ),
    );
  }

  // 券后价
  Widget renderPrice() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        '¥ ${product.actualPrice}',
        style: Get.textTheme.headline6!.copyWith(color: Colors.red,fontSize: 14),
      ),
    );
  }

  // 商品主图
  Widget renderMainImage() {
    final width = Get.width;
    final imageWidth = (width / 3) - 8;
    final url = Utils().imageHeaderHandle(product.mainPic!);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: .5,color: Colors.grey[100]!),
            color: Colors.grey[200]
          ),
          child: ExtendedImage.network(
            url,
            width: imageWidth,
            height: imageWidth,
            loadStateChanged: WidgetUtil.instance.s,
            cache: true,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: renderDiscount(),
        )
      ],
    );
  }

  // 左上角折扣
  Widget renderDiscount() {
    return Container(
      decoration: BoxDecoration(color: Colors.orange.withOpacity(.77)),
      padding: EdgeInsets.all(2),
      child: Column(
        children: [
          Icon(
            Icons.trending_down,
            size: 12,
          ),
          Text(
            '-${NumUtil.getNumByValueDouble(product.discounts! * 100, 0)}%',
            style: TextStyle(fontSize: 8,fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
