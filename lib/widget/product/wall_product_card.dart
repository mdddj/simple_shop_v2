import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/constant/app_constant.dart';
import 'package:dd_tk_shop/util/extended_util.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 瀑布流卡片
class WallProductCard extends StatelessWidget {
  final Product product;

  const WallProductCard({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetUtil.instance.detailPage(product: product);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(8)),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExtendedImage.network(
                  Utils().imageHeaderHandle(product.mainPic),
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                  loadStateChanged: WidgetUtil.instance.s,
                  cache: true,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  shape: BoxShape.rectangle,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.dtitle}',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$rmb${product.actualPrice}',
                        style: TextStyle(color: Get.theme.primaryColor),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
