import 'package:dataoke_sdk/model/product.dart';
import '../../constant/app_constant.dart';
import '../../util/widget_util.dart';
import '../../widget/list/product_horizontal_list.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(kDefaultPadded),
      margin: EdgeInsets.only(top: kDefaultPadded),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetUtil.instance.renderTitle('猜你喜欢'),
          SizedBox(
            height: 6,
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
