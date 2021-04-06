import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/constant/app_constant.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../image/layoutbuilder_image.dart';

/// 商品推荐
class RecommendIndex extends StatelessWidget {
  final List<Product> products;

  const RecommendIndex({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetUtils.isNull(products)) return Container();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: kDefaultPadded,
        crossAxisSpacing: kDefaultPadded,
      ),
      itemBuilder: itemBuilder,
      itemCount: products.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget itemBuilder(context, index) {
    return renderItem(products[index]);
  }

  // 每项布局
  Widget renderItem(Product item) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () {
            WidgetUtil.instance.detailPage(product: item);
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilderImage(url: item.mainPic,constraints: constraints),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$rmb ${item.actualPrice}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$rmb ${item.originalPrice}",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
