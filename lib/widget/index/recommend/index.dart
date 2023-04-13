import 'package:dd_models/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_constant.dart';
import '../../../util/widget_util.dart';
import '../../image/layoutbuilder_image.dart';

/// 商品推荐
class RecommendIndex extends StatelessWidget {
  final List<Product>? products;

  const RecommendIndex({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetUtils.isNull(products)) return Container();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: kDefaultPadded,
        crossAxisSpacing: kDefaultPadded,
      ),
      itemBuilder: itemBuilder,
      itemCount: products!.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget itemBuilder(BuildContext context,int index) {
    return renderItem(products![index]);
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
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilderImage(url: item.mainPic, constraints: constraints),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '$rmb ${item.actualPrice}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '$rmb ${item.originalPrice}',
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
