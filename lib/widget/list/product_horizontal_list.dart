import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/constant/app_constant.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:dd_tk_shop/util/extended_util.dart';
import 'package:get/get.dart';

double get w => (Get.width - (kDefaultPadded * 3)) / 3;

/// 商品横向列表
class ProductHorizontalList extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> itemOnTap;

  const ProductHorizontalList({Key key, this.products, this.itemOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: w * 1.5,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return renderItem(products[index]);
        },
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget renderItem(Product item) {
    return GestureDetector(
      onTap: () {
        if (itemOnTap != null) {
          itemOnTap(item);
        }
      },
      child: Container(
        width: w,
        margin: EdgeInsets.only(right: kDefaultPadded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              "${item.mainPic.imageUrl()}",
              width: w,
              height: w,
              cache: true,
              loadStateChanged: WidgetUtil.instance.s,
            ),
            Text(
              "${item.dtitle}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${item.actualPrice.toRMB()}",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
