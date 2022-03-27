import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';
import '../../util/widget_util.dart';
import '../../widget/list/product_horizontal_list.dart';

// 相似推荐商品
class LikeProducts extends StatelessWidget {
  final List<Product> products;
  const LikeProducts({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.all(kDefaultPadded),
      margin: const EdgeInsets.only(top: kDefaultPadded),
      decoration:  const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetUtil.instance.renderTitle('猜你喜欢'),
          const SizedBox(
            height: kDefaultPadded,
          ),
          ProductHorizontalList(
              products: products,
              itemOnTap: (Product item) {
                WidgetUtil.instance.detailPage(product: item, isNative: true);
              }),
        ],
      ),
    );
  }
}
